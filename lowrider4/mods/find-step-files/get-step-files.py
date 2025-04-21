#!/usr/bin/env python3
import sys, time, requests, json, re
from playwright.sync_api import sync_playwright
import cloudscraper
from bs4 import BeautifulSoup

scraper = cloudscraper.create_scraper()  # returns a requests‑compatible session

#–– CONFIG ––
USER_MODELS_URL = "https://www.printables.com/@V1Engineering/models"
# Only looking for STEP files
STEP_EXTENSIONS = (".step",)

def dump_error(resp):
    """Prints status, headers, and a 500‑char snippet of the body."""
    print(f"[ERROR] HTTP {resp.status_code} on {resp.url}", file=sys.stderr)
    print("Headers:", json.dumps(dict(resp.headers), indent=2), file=sys.stderr)
    body = resp.text or ""
    snippet = body[:500] + ("…(truncated)" if len(body) > 500 else "")
    print("Body snippet:\n", snippet, file=sys.stderr)


def fetch_step_files(files_url):
    try:
        resp = scraper.get(files_url, timeout=10)
    except Exception as e:
        print(f"[ERROR] GET {files_url} failed: {e}", file=sys.stderr)
        return []

    if resp.status_code != 200:
        dump_error(resp)
        return []

    soup = BeautifulSoup(resp.text, "html.parser")

    # Attempt to extract via embedded GraphQL payloads
    candidates = soup.find_all(
        "script",
        {"data-sveltekit-fetched": True, "data-url": re.compile(r"^https://api\.printables\.com/graphql/")}
    )
    for script in candidates:
        if not script.string:
            continue
        try:
            wrapper = json.loads(script.string)
            body = json.loads(wrapper.get("body", "{}"))
            model = body.get("data", {}).get("model", {})
            stls = model.get("stls") or []
            if stls:
                return [
                    entry.get("name")
                    for entry in stls
                    if entry.get("name", "").lower().endswith(STEP_EXTENSIONS)
                ]
        except (json.JSONDecodeError, KeyError):
            continue

    # Fallback: parse HTML under data-testid="model-files"
    files_section = soup.find("div", {"data-testid": "model-files"})
    if not files_section:
        return []

    step_files = []
    for item in files_section.find_all("div", class_="download-item"):
        for text in item.stripped_strings:
            if text.lower().endswith(STEP_EXTENSIONS):
                step_files.append(text)
                break
    return step_files


def main():
    results = []

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False, slow_mo=100)
        page = browser.new_page()
        page.set_viewport_size({"width": 1280, "height": 800})
        page.goto(USER_MODELS_URL, wait_until="networkidle")

        # Wait for model cards to load
        page.wait_for_selector("article.card", timeout=10000)

        # Scroll to load all models
        prev_count = 0
        while True:
            cards = page.query_selector_all("article.card")
            count = len(cards)
            if count == prev_count:
                break
            prev_count = count
            page.evaluate("window.scrollBy(0, document.body.scrollHeight)")
            time.sleep(1)

        anchors = page.query_selector_all("article.card a[href^='/model/']")
        seen = set()
        for a in anchors:
            href = a.get_attribute("href")
            if not href or href in seen:
                continue
            seen.add(href)

            name_elem = a.query_selector("h2, h3, .model-name")
            name = name_elem.inner_text().strip() if name_elem else href.split("/")[-1]
            files_url = f"https://www.printables.com{href}/files"
            step_list = fetch_step_files(files_url)
            if step_list:
                results.append({"name": name, "files_url": files_url, "step_files": step_list})
        browser.close()

    # Print markdown-formatted output
    for entry in results:
        name = entry["name"]
        url = entry["files_url"]
        print(f"- [{name}]({url})")
        for fn in entry["step_files"]:
            print(f"  - {fn}")


if __name__ == "__main__":
    main()
