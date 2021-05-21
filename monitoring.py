# import requests module 
import requests
import logging
import time

# Setting up Logging
logging.basicConfig(level = logging.INFO)
logger = logging.getLogger()

# URL
url = "https://google.com"


# Make request method
def make_request(url):
    logging.info("Fetching URL")
    try:
        response = requests.get(url)
        # print response
        logger.info(f"Response from URL: {str(response).split()[-1]}")
        # print elapsed time
        logger.info(f"Elapsed time: {response.elapsed.total_seconds()}")
    except requests.exceptions.RequestException as e:
        logger.critical(f"Unable to fecth URL: {url}")
        raise SystemExit(e)

def main():
    logging.info("Starting monitoring application")
    while True:
        # Call make_request method
        make_request(url)
        # Run every 60 seconds
        time.sleep(60)

if __name__ == "__main__":
    main()