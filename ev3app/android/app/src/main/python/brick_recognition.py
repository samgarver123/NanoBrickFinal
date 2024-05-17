from PIL import Image
from rembg import remove, new_session
import requests
import argparse
import cv2
import os

# Constant for expanding the size of the bounding box
EXPANDED_PIXELS = 50

# Remove the background of an image
def remove_bg(input_path):
    input = Image.open(input_path) 
    session = new_session('isnet-general-use')
    return remove(input, session=session) 


# Make a transparent image black and white
def make_transparent_black_white(img, output_path, threshold=50):
    img = img.convert("RGBA")
    pixels = img.load()

    for y in range(img.size[1]):
        for x in range(img.size[0]):
            _, _, _, a = pixels[x, y]

            if int(a) < threshold:
                pixels[x, y] = (0, 0, 0, 255)  # Black
            else:
                pixels[x, y] = (255, 255, 255, 255)  # White
    
    img.save(output_path)


# Expand bounding box dimensions
def expand_bounding_box(box, expand_pixels):
    x1, y1, x2, y2 = box
    x1 -= expand_pixels
    y1 -= expand_pixels
    x2 += expand_pixels
    y2 += expand_pixels
    return x1, y1, x2, y2


# Process the black and white image
def process_black_and_white(black_and_white_input, original_input, output_directory):
    # Read image
    image = cv2.imread(black_and_white_input, cv2.IMREAD_GRAYSCALE)
    contours, _ = cv2.findContours(image, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Make directory
    os.makedirs(output_directory, exist_ok=True)

    # Iterate through the contours and draw bounding boxes
    expanded_bounding_boxes = []
    for contour in contours:
        x, y, w, h = cv2.boundingRect(contour)
        expanded_box = expand_bounding_box((x, y, x + w, y + h), EXPANDED_PIXELS)
        expanded_bounding_boxes.append(expanded_box)

    # Apply and save cropped images
    other_image = cv2.imread(original_input)
    for i, box in enumerate(expanded_bounding_boxes):
        x1, y1, x2, y2 = box
        cropped_image = other_image[y1:y2, x1:x2]
        cv2.imwrite(os.path.join(output_directory, f'cropped_{i}.jpg'), cropped_image)


# Extract images from input file and store cropped images in output dir
def extract_images_pipeline(input_file, output_directory):
    black_and_white_path = 'black_and_white.png'
    make_transparent_black_white(remove_bg(input_file), black_and_white_path)
    process_black_and_white(black_and_white_path, input_file, output_directory)
    os.remove(black_and_white_path)


# Recognize image using brickognize
def recognize(image_path):
    url = "https://api.brickognize.com/predict/"
    files = {'query_image': (image_path, open(image_path, 'rb'), 'image/jpg')}
    response = requests.post(url, files=files)
    if response.status_code == 200:
        brick_info = response.json()
        label = brick_info["items"][0]["id"]
        return label


# Parse arguments
def parse_arguments():
    parser = argparse.ArgumentParser(description="Script to remove background from input image and extract cropped images of recognized objects.")
    parser.add_argument("input_file", type=str, help="Path to the input image file")
    parser.add_argument("output_dir", type=str, help="Path to the output directory for cropped images")
    return parser.parse_args()


# Run script
if __name__ == "__main__":
    # Parse command line arguments
    args = parse_arguments()
    
    # Set paths from command line arguments
    input_file = args.input_file
    output_dir = args.output_dir

    # Extract images
    extract_images_pipeline(input_file, output_dir)

    bricks = {}
    for root, _, files in os.walk(output_dir):
        for file in files:
            # Get image information
            image_path = os.path.abspath(os.path.join(root, file))

            # Query brickognize
            try: 
                label = recognize(image_path)
                if label in bricks:
                    bricks[label] += 1
                else:
                    bricks[label] = 1

            # Skip images with no result   
            except:
                continue

    # Return results
    print(bricks)
