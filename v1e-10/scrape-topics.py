# Created to download images from a Discourse based forum like https://forum.v1e.com/t/10-years-of-v1/48075

# Started with https://chatgpt.com/share/67ae494f-a344-800b-b352-46c8772b0c89, but then kept going...

import os
import csv
import json
import requests
import argparse
from datetime import datetime
from urllib.parse import urljoin, urlparse, quote
from bs4 import BeautifulSoup

# Global counters for summary stats
total_topics_processed = 0
total_images_processed = 0
total_bytes_downloaded = 0

# Global dictionary to accumulate encountered users
encountered_users = {}

# Globals...
verbose_enabled = False

# ---------------------------------
# Configuration
# ---------------------------------
BASE_URL = "https://forum.v1e.com"
TAGS_TO_FETCH = ["gallery-lowrider-cnc", "gallery-mpcnc"]

# API headers if needed
API_HEADERS = {
    # 'Api-Key': '<YOUR_DISCOURSE_API_KEY>',
    # 'Api-Username': '<YOUR_DISCOURSE_USERNAME>'
}

# Directory where images and metadata CSV files are saved
DOWNLOAD_BASE_DIR = ".output"
CACHE_DIR = ".cache"

# ---------------------------------
# Helper Functions
# ---------------------------------
def verbose(s : str):
    if verbose_enabled:
        print(s)

def sanitize_filename(filename: str) -> str:
    """Remove or replace characters not safe for filenames."""
    return "".join(char for char in filename if char.isalnum() or char in ("-", "_", ".", " "))

def ensure_dir(directory_path: str):
    """Create the directory if it doesn't exist."""
    if not os.path.exists(directory_path):
        os.makedirs(directory_path)

def get_cache_path(url: str) -> str:
    """
    Generate a cache file path for a given URL.
    The path is based on the URL's host and path components.
    """
    parsed = urlparse(url)
    # Build a folder structure: CACHE_DIR/host/...
    parts = parsed.path.strip("/").split("/")
    folder = os.path.join(CACHE_DIR, parsed.netloc, *parts[:-1])
    ensure_dir(folder)
    filename = parts[-1] if parts and parts[-1] else "index"
    if parsed.query:
        # Append a sanitized version of the query string
        query_hash = quote(parsed.query, safe="")
        filename += "_" + query_hash
    if not filename.endswith(".json"):
        filename += ".json"
    return os.path.join(folder, filename)

def fetch_json(url: str, params=None):
    """Fetch JSON data from a URL and handle network errors gracefully."""
    print(f"Fetching JSON: {url}")
    try:
        r = requests.get(url, params=params, headers=API_HEADERS, timeout=10)
        r.raise_for_status()
        return r.json()
    except requests.exceptions.RequestException as e:
        print(f"Error fetching JSON from {url}: {e}")
        return None


def cached_fetch_json(url: str, use_cache: bool = True):
    """
    Fetch JSON data from a URL with local caching.
    If use_cache is True and a cached version exists, return that.
    Otherwise, fetch from the network and save the result to the cache.
    """
    cache_path = get_cache_path(url)
    if use_cache and os.path.exists(cache_path):
        verbose(f"Loading cached data from {cache_path}")
        try:
            with open(cache_path, "r", encoding="utf-8") as f:
                return json.load(f)
        except Exception as e:
            print(f"Error loading cache {cache_path}: {e}")
    
    print(f"Fetching data from {url}")
    data = fetch_json(url)
    if data and use_cache:
        try:
            with open(cache_path, "w", encoding="utf-8") as f:
                json.dump(data, f)
        except Exception as e:
            print(f"Error writing cache to {cache_path}: {e}")

    return data


def get_topics_for_tag(tag: str, use_cache: bool = True):
    """
    Fetch and return all topics for a given tag from the forum,
    handling pagination via the 'more_topics_url' field.
    
    Also accumulate encountered users from each API response into the
    global encountered_users table.
    """
    topics = []
    url = f"{BASE_URL}/tag/{tag}.json"
    while url:
        data = cached_fetch_json(url, use_cache=use_cache)
        if not data:
            break
        topic_list = data.get("topic_list", {})
        topics_batch = topic_list.get("topics", [])
        topics.extend(topics_batch)
        # Process user objects from this response
        for user in data.get("users", []):
            encountered_users[user["id"]] = user
        # Check for pagination: if 'more_topics_url' is provided, continue
        more_url = topic_list.get("more_topics_url", None)
        if more_url:
            if "?" in more_url and ".json" not in more_url.split("?")[0]:  
                more_url = more_url.replace("?", ".json?", 1)  # Insert ".json" before the first "?"
            url = urljoin(BASE_URL, more_url)
        else:
            url = None
    print(f"Fetched total {len(topics)} topics for tag '{tag}'")
    return topics


def get_topic_details(topic_id: int, use_cache: bool = True):
    """Fetch the complete details for a topic, including posts."""
    url = f"{BASE_URL}/t/{topic_id}.json"
    data = cached_fetch_json(url, use_cache=use_cache)
    if not data:
        return {}
    return data


def parse_images_from_post_html(cooked_html: str):
    """Extract image URLs from the post's cooked HTML."""
    soup = BeautifulSoup(cooked_html, "html.parser")
    images = []
    for img_tag in soup.find_all("img"):
        src = img_tag.get("src")
        if src and not src.lower().startswith("http"):
            src = urljoin(BASE_URL, src)
        if src:
            images.append(src)
    return images


def download_file(url: str, filepath: str):
    """Download a file from URL to a local filepath if it doesn't already exist."""
    if os.path.exists(filepath):
        verbose(f"Download file, skipping existing, path: {filepath}")
        return

    print(f"Download file, url : {url}, path: {filepath}")
    try:
        response = requests.get(url, headers=API_HEADERS, stream=True, timeout=10)
        response.raise_for_status()
        with open(filepath, "wb") as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
    except requests.exceptions.RequestException as e:
        print(f"Error downloading {url}: {e}")
        raise


def write_users_csv(users: dict):
    """Write the accumulated users data to a CSV file."""
    csv_path = os.path.join(DOWNLOAD_BASE_DIR, "users.csv")
    with open(csv_path, mode="w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(["id", "name", "username", "avatar_template"])
        for user in users.values():
            writer.writerow([
                user.get("id"),
                user.get("name"),
                user.get("username"),
                user.get("avatar_template")
            ])
    print(f"Users CSV written to {csv_path}")


def process_single_topic(topic, tag_dir, topics_writer, images_writer, max_images, min_likes, skip_download, use_cache):
    """
    Process one topic:
      - Fetch topic details.
      - Choose the best post (with >= min_likes and with images).
      - Write one row to topics_writer.
      - For each image (up to max_images), download (unless skip_download) and write a row to images_writer.
    Returns True if topic processed successfully, False otherwise.
    """
    topic_id = topic.get("id")
    topic_title = topic.get("title", "No Title")
    topic_created = topic.get("created_at", None) or datetime.now().isoformat()
    author_username = topic.get("author_username", "unknown_author")
    author_name = author_username
    reply_count = topic.get("reply_count", 0)
    view_count = topic.get("views", 0)

    try:
        dt = datetime.fromisoformat(topic_created.replace("Z", "+00:00"))
    except ValueError:
        dt = datetime.now()
    date_prefix = dt.strftime("%Y-%m-%d_%H-%M-%S")
    prefix = f"{date_prefix}__{topic_id}"

    topic_data = get_topic_details(topic_id, use_cache=use_cache)
    if not topic_data:
        print(f"Skipping topic {topic_id} due to fetch error.")
        return False

    # TODO: Maybe implement getting paginated batches of Post data for long Topics
    posts = topic_data.get("post_stream", {}).get("posts", [])
    if not posts:
        print(f"No posts found in topic {topic_id}")
        return False

    # If topic-level author unknown, get from the first post.
    if author_username == "unknown_author" and posts:
        author_username = posts[0].get("username", author_username)
        author_name = posts[0].get("name", author_name)

    # Sort posts by reaction_users_count (like count) descending and pick the first with images.
    posts_sorted = sorted(posts, key=lambda p: p.get("reaction_users_count", 0), reverse=True)
    chosen_post = None
    chosen_images = []
    for post in posts_sorted:
        if post.get("reaction_users_count", 0) >= min_likes:
            images = parse_images_from_post_html(post.get("cooked", ""))
            if images:  # Only choose post if it has at least one image.
                chosen_post = post
                chosen_images = images
                break

    if not chosen_post:
        print(f"Topic {topic_id}: No post meets min_likes ({min_likes}) with images. Skipping.")
        return False

    chosen_post_id = chosen_post.get("id")
    post_like_count = chosen_post.get("reaction_users_count", 0)

    # Remove user_avatar images embedded within a post (because of quote within the post)
    if chosen_images is not None:
        chosen_images = [img for img in chosen_images if "/user_avatar/" not in img]
    else:
        # Optionally, initialize chosen_images as an empty list if needed
        chosen_images = []


    # If the topic has a default image URL, use that instead of the post images.
    default_image_url = topic_data.get("image_url")
    if default_image_url and default_image_url not in chosen_images:
        chosen_images.insert(0, default_image_url)

    # Limit to max_images from the chosen post.
    chosen_images = chosen_images[:max_images]

    verbose(f"Topic {topic_id}: Selected post {chosen_post_id} with {post_like_count} likes has {len(chosen_images)} image(s) (max {max_images}).")

    # Write topic-level metadata.
    topics_writer.writerow([
        topic_id,
        dt.isoformat(),
        author_username,
        author_name,
        topic_title,
        chosen_post_id,
        post_like_count,
        reply_count,
        view_count
    ])

    # Process each image.
    for img_url in chosen_images:
        if skip_download:
            final_filename = "SKIPPED_" + os.path.basename(img_url)
            file_size = 0
        else:
            img_name = os.path.basename(img_url)
            img_name_sanitized = sanitize_filename(img_name)
            final_filename = f"{prefix}_{chosen_post_id}_{img_name_sanitized}"
            final_filepath = os.path.join(tag_dir, final_filename)
            try:
                download_file(img_url, final_filepath)
                file_size = os.path.getsize(final_filepath)
            except Exception as e:
                print(f"Error processing image {img_url}: {e}")
                continue

        # Write image-level metadata.
        images_writer.writerow([
            topic_id,
            chosen_post_id,
            final_filename,
            img_url
        ])
    return True

def process_tag(tag: str, topic_limit: int = None, max_images: int = 5, min_likes: int = 3,
                skip_download: bool = False, use_cache: bool = True, fetch_topics: bool = False):
    """
    Process topics for a given tag:
      - Fetch all topics (with pagination and caching).
      - For each topic (up to topic_limit if provided), process and write out:
            * One row in the topics CSV.
            * One row per image (from the chosen post) in the images CSV.
    """
    global total_topics_processed, total_images_processed, total_bytes_downloaded

    tag_dir = os.path.join(DOWNLOAD_BASE_DIR, tag)
    ensure_dir(tag_dir)

    topics_csv_path = os.path.join(tag_dir, f"{tag}_topics.csv")
    images_csv_path = os.path.join(tag_dir, f"{tag}_images.csv")

    topics_file = open(topics_csv_path, mode="w", newline="", encoding="utf-8")
    images_file = open(images_csv_path, mode="w", newline="", encoding="utf-8")

    topics_writer = csv.writer(topics_file)
    images_writer = csv.writer(images_file)

    # Write headers.
    topics_writer.writerow([
        "topic_id", "created_datetime", "username", "name",
        "title", "chosen_post_id", "like_count", "reply_count", "view_count"
    ])
    images_writer.writerow([
        "topic_id", "chosen_post_id", "image_filename", "image_url"
    ])

    topics = get_topics_for_tag(tag, use_cache = use_cache and not fetch_topics)
    if not topics:
        print(f"No topics found for tag {tag}")
        topics_file.close()
        images_file.close()
        return

    topics_processed_in_tag = 0
    for topic in topics:
        if topic_limit is not None and topics_processed_in_tag >= topic_limit:
            print(f"Topic limit of {topic_limit} reached for tag {tag}.")
            break

        processed = process_single_topic(topic, tag_dir, topics_writer, images_writer,
                                         max_images, min_likes, skip_download, use_cache)
        if processed:
            topics_processed_in_tag += 1
            total_topics_processed += 1
            # Note: total_images_processed and total_bytes_downloaded are updated within download_file, if desired.
    
    topics_file.flush()
    images_file.flush()
    topics_file.close()
    images_file.close()
    print(f"Done processing tag: {tag}.")
    print(f"Topics CSV saved to {topics_csv_path}")
    print(f"Images CSV saved to {images_csv_path}")


def main(
        topic_limit: int = None, 
        max_images: int = 5, 
        min_likes: int = 3, 
        skip_download: bool = False,
        use_cache: bool = True,
        fetch_topics: bool = False):
    
    ensure_dir(DOWNLOAD_BASE_DIR)
    for tag in TAGS_TO_FETCH:
        process_tag(
            tag,
            topic_limit,
            max_images,
            min_likes,
            skip_download,
            use_cache,
            fetch_topics)

    # Write the encountered users to CSV for later reference
    write_users_csv(encountered_users)

    # Print summary stats
    print("\n----- Summary -----")
    print(f"Total topics processed: {total_topics_processed}")
    print(f"Total images processed: {total_images_processed}")
    if not skip_download:
        mb = total_bytes_downloaded / (1024 * 1024)
        print(f"Total bytes downloaded: {total_bytes_downloaded} bytes ({mb:.2f} MB)")
    else:
        print("Download skipped; no data size to report.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Download images and metadata from the forum.")
    parser.add_argument("-topic-limit", type=int, default=None,
                        help="Limit the number of topics processed per tag.")
    parser.add_argument("-max-images", type=int, default=5,
                        help="Maximum number of images to download from a given post (default: 5).")
    parser.add_argument("-min-likes", type=int, default=3,
                        help="Minimum number of likes a post must have to download its images (default: 3).")
    parser.add_argument("-skip-download", action="store_true",
                        help="Skip downloading images; only gather metadata and count potential downloads.")
    parser.add_argument("-no-cache", action="store_true",
                        help="Do not use cached API responses (default uses cache).")
    parser.add_argument("-fetch-topics", action="store_true",
                        help="Force fetching Topics list, ignore cached Topics list.  But does NOT "
                        "fetch each Topic again.  Cached data for each Topic remains.  Use to fetch "
                        "new gallery topics, without having to fetch all the known Topics again.  "
                        "TODO: Ideally, should do something smarter that doesn't miss updates to cached topics.")
    parser.add_argument("-verbose", "-v", action="store_true",
                        help="Enable verbose logging.")
    args = parser.parse_args()

    # use_cache is True unless --no-cache is provided
    use_cache = not args.no_cache
    
    verbose_enabled = args.verbose
    
    main(
        topic_limit=args.topic_limit,
        max_images=args.max_images,
        min_likes=args.min_likes,
        skip_download=args.skip_download,
        use_cache=use_cache,
        fetch_topics=args.fetch_topics)
