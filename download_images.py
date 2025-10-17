import requests
import os
import time


API_KEY = 'CSf2yUOHtjzPp02u3Xr5XkyPLW1WoddJ2IDceFrNVFDqwZ4H66CwcxUk'

OUTPUT_FOLDER = 'downloaded_images'

# English alphabet words (A-Z)
ENGLISH_WORDS = {
    'a': 'apple',
    'b': 'ball',
    'c': 'cat',
    'd': 'dog',
    'e': 'elephant',
    'f': 'fish',
    'g': 'grapes',
    'h': 'house',
    'i': 'ice cream',
    'j': 'jug',
    'k': 'kite',
    'l': 'lion',
    'm': 'monkey',
    'n': 'nest',
    'o': 'orange',
    'p': 'parrot',
    'q': 'queen',
    'r': 'rabbit',
    's': 'sun',
    't': 'tiger',
    'u': 'umbrella',
    'v': 'van',
    'w': 'watch',
    'x': 'xylophone',
    'y': 'yak',
    'z': 'zebra'
}

def download_image(query, filename):
    """Download a single image from Pexels"""
    url = f'https://api.pexels.com/v1/search?query={query} for kids&per_page=1&orientation=landscape'

    headers = {
        'Authorization': API_KEY
    }

    try:
        print(f'🔍 Searching: {query}...')
        response = requests.get(url, headers=headers)

        if response.status_code == 200:
            data = response.json()

            if data['photos'] and len(data['photos']) > 0:
                # Get large size image
                image_url = data['photos'][0]['src']['large']

                print(f'📥 Downloading: {filename}...')

                # Download the image
                img_response = requests.get(image_url)

                if img_response.status_code == 200:
                    # Save image to file
                    filepath = os.path.join(OUTPUT_FOLDER, filename)
                    with open(filepath, 'wb') as f:
                        f.write(img_response.content)

                    print(f'✅ Saved: {filename}\n')
                    return True
                else:
                    print(f'❌ Failed to download: {filename}\n')
            else:
                print(f'⚠️  No image found for: {query}\n')
        else:
            print(f'❌ API Error: Status Code {response.status_code}')
            if response.status_code == 401:
                print('⚠️  Invalid API key! Please check your API key.\n')
            elif response.status_code == 403:
                print('⚠️  Access forbidden. Check API key permissions.\n')
            elif response.status_code == 429:
                print('⚠️  Rate limit exceeded. Wait and try again.\n')

    except Exception as e:
        print(f'❌ Error: {e}\n')

    return False

def main():
    """Main function to download all images"""
    print('=' * 60)
    print('🎨 PEXELS IMAGE DOWNLOADER FOR LEARNING APP')
    print('=' * 60)
    print()

    # Check if API key is set
    if API_KEY == 'YOUR_API_KEY_HERE':
        print('❌ ERROR: API key not found!')
        print()
        print('Please add your Pexels API key in line 5 of this script.')
        print('Get your free API key from: https://www.pexels.com/api/')
        print()
        input('Press Enter to exit...')
        return

    # Create output folder if it doesn't exist
    if not os.path.exists(OUTPUT_FOLDER):
        os.makedirs(OUTPUT_FOLDER)
        print(f'📁 Created folder: {OUTPUT_FOLDER}/')
    else:
        print(f'📁 Using existing folder: {OUTPUT_FOLDER}/')

    print(f'💾 Images will be saved in: {os.path.abspath(OUTPUT_FOLDER)}/')
    print()
    print('📚 DOWNLOADING ENGLISH ALPHABET IMAGES (A-Z)')
    print('-' * 60)
    print()

    success_count = 0
    total_count = len(ENGLISH_WORDS)

    # Download each image
    for letter, word in ENGLISH_WORDS.items():
        filename = f'{letter}_{word.replace(" ", "_")}.jpg'

        if download_image(word, filename):
            success_count += 1

        # Wait 1.5 seconds between requests (API rate limit respect)
        time.sleep(1.5)

    # Summary
    print()
    print('=' * 60)
    print(f'✅ DOWNLOAD COMPLETE!')
    print('=' * 60)
    print(f'📊 Successfully downloaded: {success_count}/{total_count} images')
    print(f'📁 Images saved in: {os.path.abspath(OUTPUT_FOLDER)}/')
    print()
    print('📋 Next Steps:')
    print('1. Check the downloaded_images folder')
    print('2. Copy images to your Flutter project: assets/images/')
    print('3. Update pubspec.yaml if needed')
    print('4. Run your Flutter app!')
    print()
    input('Press Enter to exit...')

if __name__ == '__main__':
    main()