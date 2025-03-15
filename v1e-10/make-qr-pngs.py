import os
import csv
import qrcode
from typing import List

# Global configuration for QR Code
# Directory where images and metadata CSV files are saved
DOWNLOAD_BASE_DIR = ".output"
CACHE_DIR = ".cache"
QR_VERSION = 1  # Basic QR code (21x21 modules)
ERROR_CORRECTION = qrcode.constants.ERROR_CORRECT_L
BOX_SIZE = 10   # Each module is 10 pixels
BORDER = 4      # Border width in modules (~290x290 image size)

# Using #FF2600 instead of pure #FF0000 so QR code remains both distinctly red and easily 
# perceptible, even to individuals with red–green color blindness.
# See https://chatgpt.com/share/67d508fa-eb7c-800b-b461-48b988e19777 
QR_FILL_COLOR = "#FF2600"
QR_BACK_COLOR = "black"
FORCE_GENERATE = False

def find_csv_files(base_dir: str) -> List[str]:
    """
    Recursively find all .csv files in the given base directory.
    """
    csv_files = []
    for root, _, files in os.walk(base_dir):
        for file in files:
            if file.lower().endswith(".csv"):
                csv_files.append(os.path.join(root, file))
    return csv_files


def process_csv_file(csv_path: str) -> None:
    """
    Process a CSV file. If the first header is 'topic_id', generate a QR code for each row.
    The generated QR code images are saved in a 'qr' subfolder located in the same directory as the CSV.
    """
    with open(csv_path, newline='', encoding='utf-8') as csvfile:
        reader = csv.reader(csvfile)
        try:
            header = next(reader)
        except StopIteration:
            return  # Skip empty CSV files

        if not header or header[0].strip().lower() != "topic_id":
            return  # Skip files where the first header is not 'topic_id'

        # Create a "qr" subfolder in the same folder as the CSV file
        folder = os.path.dirname(csv_path)
        qr_dir = os.path.join(folder, "qr")
        os.makedirs(qr_dir, exist_ok=True)
        
        # Process each row in the CSV file
        for row in reader:
            if not row:
                continue
            topic_id = row[0].strip()
            if not topic_id:
                continue
            
            target_filename = f"qr_topic_{topic_id}.png"
            target_path = os.path.join(qr_dir, target_filename)
            
            # Only create and save the QR code if the file does not already exist
            if FORCE_GENERATE or not os.path.exists(target_path):
                generate_qr_code(topic_id, target_path)


def generate_qr_code(topic_id: str, output_path: str) -> None:
    """
    Generate a QR code for the given topic_id and save it to output_path.
    The QR code encodes the URL 'https://forum.v1e.com/t/<topic_id>'.
    The QR code will have red square markers on a black background.
    """
    url = f"https://forum.v1e.com/t/{topic_id}"
    qr = qrcode.QRCode(
        version=QR_VERSION,
        error_correction=ERROR_CORRECTION,
        box_size=BOX_SIZE,
        border=BORDER,
    )
    qr.add_data(url)
    qr.make(fit=True)
    
    # Create an image with red fill and black background
    img = qr.make_image(fill_color = QR_FILL_COLOR, back_color = QR_BACK_COLOR)
    img.save(output_path)
    print(f"Generated QR for topic_id {topic_id} at {output_path}")


def main() -> None:
    csv_files = find_csv_files(DOWNLOAD_BASE_DIR)
    
    for csv_file in csv_files:
        process_csv_file(csv_file)

if __name__ == "__main__":
    main()
