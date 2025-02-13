# Created to download images from a Discourse based forum like https://forum.v1e.com/t/10-years-of-v1/48075

# https://chatgpt.com/share/67ae494f-a344-800b-b352-46c8772b0c89

#!/usr/bin/env python3

import os
import re
import json
import requests
from bs4 import BeautifulSoup
from datetime import datetime

# Tags we want to retrieve
TAGS = [
    "gallery-lowrider-cnc",
    "gallery-mpcnc"
]

# Base URLs and endpoints
BASE_URL = "https://forum.v1e.com"
TAG_ENDPOINT = "/tag"  # We will do GET /tag/{tag}.json
TOPIC_ENDPOINT = "/t"  # We will do GET /t/{topic_id}.json

# Where to store downloaded images
OUTPUT_DIR = "downloaded_images"
os.makedirs(OUTPUT_DIR, exist_ok=True)

# For storing overall metadata
METADATA_FILENAME = "images_metadata.json"

def sanitize_filename(filename: str) -> str:
    """
    Replace any non-alphanumeric, non-underscore, non-dot, non-space,
    non-hyphen characters with underscores.
    """
    return re.sub(r'[^\w.\- ]', '_', filename)

def fetch_topics_for_tag(tag: str):
    """
    Return the list of topics for a given tag.
    """
    url = f"{BASE_URL}{TAG_ENDPOINT}/{tag}.json"
    print(f"Fetching topics for tag: {tag} -> {url}")
    resp = requests.get(url)
    resp.raise_for_status()
    
    data = resp.json()
    # Topics are nested inside data['topic_list']['topics']
    topics = data.get("topic_list", {}).get("topics", [])
    return topics

def fetch_topic_data(topic_id: int):
    """
    Return the JSON data for a specific topic (including the full post stream).
    """
    url = f"{BASE_URL}{TOPIC_ENDPOINT}/{topic_id}.json"
    print(f"Fetching topic data for topic_id: {topic_id} -> {url}")
    resp = requests.get(url)
    resp.raise_for_status()
    return resp.json()

def extract_images_from_html(html: str):
    """
    Parse the cooked HTML of a Discourse post and extract image URLs.
    Return a list of image URLs found.
    """
    soup = BeautifulSoup(html, "html.parser")
    image_urls = []
    
    # Discourse typically uses <img src="..."> for embedded images
    for img in soup.find_all("img"):
        src = img.get("src")
        if src:
            # Some images might be emojis or external resources; you can filter by domain if needed
            image_urls.append(src)
    return image_urls

def download_image(url: str, save_path: str):
    """
    Download the image from `url` and save it to `save_path`.
    """
    print(f"Downloading image: {url} -> {save_path}")
    resp = requests.get(url, stream=True)
    resp.raise_for_status()
    
    with open(save_path, "wb") as f:
        for chunk in resp.iter_content(chunk_size=8192):
            f.write(chunk)

def main():
    # Collect all metadata in a list
    all_metadata = []
    
    # Process each tag
    for tag in TAGS:
        topics = fetch_topics_for_tag(tag)
        
        for topic in topics:
            topic_id = topic["id"]
            topic_title = topic["title"]
            # We'll fetch the full topic data to get the posts
            topic_data = fetch_topic_data(topic_id)
            
            # The entire post stream is in topic_data["post_stream"]["posts"]
            posts = topic_data.get("post_stream", {}).get("posts", [])
            
            for post in posts:
                post_username = post.get("username", "unknown_user")
                post_created_at = post.get("created_at", "")
                
                # Convert creation date to a local date format
                # created_at might look like "2023-01-05T13:40:22.864Z"
                # We'll parse it with datetime.fromisoformat or strptime
                try:
                    dt = datetime.fromisoformat(post_created_at.replace("Z", "+00:00"))
                    date_prefix = dt.strftime("%Y-%m-%d")
                except ValueError:
                    date_prefix = "unknown_date"
                
                # The "cooked" field has the HTML content
                cooked_html = post.get("cooked", "")
                image_urls = extract_images_from_html(cooked_html)
                
                # Sometimes you can also look in post["images"] or post["uploads"] 
                # if Discourse includes them, but "cooked" is fairly standard.
                
                # Download each image
                for img_url in image_urls:
                    # Some image URLs might be relative or contain //forum
                    # If they start with '/', we need to prefix with BASE_URL
                    if img_url.startswith("/"):
                        img_url = f"{BASE_URL}{img_url}"
                    
                    # Try to get a filename from the URL
                    original_filename = img_url.split("/")[-1]
                    original_filename = sanitize_filename(original_filename)
                    
                    # Construct a local filename with the date prefix
                    local_filename = f"{date_prefix}_{original_filename}"
                    save_path = os.path.join(OUTPUT_DIR, local_filename)
                    
                    # Download the image
                    try:
                        download_image(img_url, save_path)
                        
                        # Add metadata
                        all_metadata.append({
                            "topic_id": topic_id,
                            "topic_title": topic_title,
                            "post_username": post_username,
                            "post_created_at": post_created_at,
                            "image_url": img_url,
                            "local_path": save_path
                        })
                        
                    except Exception as e:
                        print(f"Failed to download {img_url}: {e}")
    
    # Finally, save all metadata to a JSON file
    with open(METADATA_FILENAME, "w", encoding="utf-8") as f:
        json.dump(all_metadata, f, indent=2, ensure_ascii=False)

if __name__ == "__main__":
    main()

