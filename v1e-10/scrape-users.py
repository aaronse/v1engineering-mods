#!/usr/bin/env python3
"""
Prompt:
Create python script to load and parse attached user.csv stored at /.output/users.csv.  Include this Prompt as a comment in the python script.  Ensure magic constants are at beginning of script, and annotated.

- Download each user .png file to a /.output/users/ folder
- Rename the .png to <username>.png, for example this data:
- Replace {size} token in avatar_template URL path field with 48
- Use Base download URL "https://forum.v1e.com"
- Example expected behavior.  This data :
    id,name,username,avatar_template
    10186,Aza B2C,azab2c,/user_avatar/forum.v1e.com/azab2c/{size}/98228_2.png
  Should download https://forum.v1e.com/user_avatar/forum.v1e.com/azab2c/48/98228_2.png and save locally to /.output/users/azab2c.png
"""

# Magic constants (Configuration variables)
CSV_PATH = ".output/users.csv"      # Path to the CSV file containing user data
OUTPUT_DIR = ".output/users/"       # Directory where downloaded .png files will be stored
BASE_URL = "https://forum.v1e.com"   # Base URL for downloading avatars
AVATAR_SIZE = "48"                   # Value to replace the {size} token in avatar_template URLs

import os
import csv
import requests

def download_avatar(username, avatar_template):
    """
    Download the avatar image for a given username.
    
    Args:
        username (str): The user's username.
        avatar_template (str): The avatar template URL containing the {size} token.
    """
    # Replace {size} with the specified AVATAR_SIZE constant
    avatar_path = avatar_template.replace("{size}", AVATAR_SIZE)
    # Construct the full URL for the avatar image
    url = BASE_URL + avatar_path
    print(f"Downloading avatar for {username} from {url}")
    
    # Download the image
    response = requests.get(url)
    if response.status_code == 200:
        # Save the image as <username>.png in the OUTPUT_DIR folder
        file_path = os.path.join(OUTPUT_DIR, f"{username}.png")
        with open(file_path, "wb") as f:
            f.write(response.content)
        print(f"Saved avatar to {file_path}")
    else:
        print(f"Failed to download avatar for {username}. Status code: {response.status_code}")

def main():
    # Ensure the output directory exists
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    # Open and parse the CSV file containing user data
    try:
        with open(CSV_PATH, newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                username = row["username"]
                avatar_template = row["avatar_template"]
                download_avatar(username, avatar_template)
    except FileNotFoundError:
        print(f"CSV file not found at {CSV_PATH}")

if __name__ == "__main__":
    main()
