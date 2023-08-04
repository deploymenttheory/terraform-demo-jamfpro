import requests
import argparse
import json
import base64
import logging

BASE_URL = "https://www.virustotal.com/api/v3/urls/"
HEADERS = {"accept": "application/json"}
API_KEY = None

def get_url_id(url):
    """
    Encode the URL into base64 format.

    Parameters:
    url (str): URL to be encoded.

    Returns:
    str: The base64 encoded URL.
    """
    url_id = base64.urlsafe_b64encode(url.encode()).decode().strip("=")
    return url_id

def handle_http_errors(response):
    """
    Handle HTTP errors based on status code.

    Parameters:
    response (requests.models.Response): The HTTP response received.

    Returns:
    str: The error message associated with the HTTP status code.
    """
    status_code = response.status_code
    if response.json():
        error_message = response.json().get('message')
    else:
        error_message = response.text

    if not error_message:
        error_message = f"An unknown error occurred. Status code: {status_code}"

    return error_message


def make_request(endpoint, method="GET", data=None):
    """
    Send an HTTP request and handle any errors.

    Parameters:
    endpoint (str): The API endpoint to send the request to.
    method (str, optional): The HTTP method to use for the request. Defaults to "GET".
    data (dict, optional): The data to send with the request. Defaults to None.

    Returns:
    dict: The JSON response from the server.
    """
    url = BASE_URL + endpoint
    headers = HEADERS.copy()
    headers["x-apikey"] = API_KEY
    timeout = 5  # Set timeout to 5 seconds

    if method == "GET":
        response = requests.get(url, headers=headers, timeout=timeout)
    elif method == "POST":
        response = requests.post(url, headers=headers, json=data, timeout=timeout)
    
    if response.status_code != 200:
        error_message = handle_http_errors(response)
        raise Exception(error_message)

    return response.json()

def scan_url(url_id):
    """
    Scan a URL using the VirusTotal API.

    Parameters:
    url_id (str): The base64 encoded URL to scan.

    Returns:
    dict: The JSON response from the server.
    """
    data = {"url": url_id}
    return make_request("", "POST", data)

def rescan_url(url_id):
    """
    Rescan a URL using the VirusTotal API.

    Parameters:
    url_id (str): The base64 encoded URL to rescan.

    Returns:
    dict: The JSON response from the server.
    """
    return make_request(f"{url_id}/analyse", "POST")

def get_comments_on_url(url_id):
    """
    Get the comments on a URL using the VirusTotal API.

    Parameters:
    url_id (str): The base64 encoded URL to get comments for.

    Returns:
    dict: The JSON response from the server.
    """
    return make_request(f"{url_id}/comments?limit=10")

def add_comment_on_url(url_id, comment_text):
    """
    Add a comment on a URL using the VirusTotal API.

    Parameters:
    url_id (str): The base64 encoded URL to add a comment on.
    comment_text (str): The comment text to add.

    Returns:
    dict: The JSON response from the server.
    """
    payload = {
        "data": {
            "type": "comment",
            "attributes": {
                "text": comment_text
            }
        }
    }
    return make_request(f"{url_id}/comments", "POST", payload)

def get_related_objects(url_id):
    """
    Get the related objects of a URL using the VirusTotal API.

    Parameters:
    url_id (str): The base64 encoded URL to get related objects for.

    Returns:
    dict: The JSON response from the server.
    """
    return make_request(f"{url_id}/relationship?limit=10")

def get_related_descriptors(url_id):
    """
    Get the related descriptors of a URL using the VirusTotal API.

    Parameters:
    url_id (str): The base64 encoded URL to get related descriptors for.

    Returns:
    dict: The JSON response from the server.
    """
    return make_request(f"{url_id}/relationships/relationship?limit=10")

def get_virus_report(url_id):
    """
    Get the virus report of a URL using the VirusTotal API.

    Parameters:
    url_id (str): The base64 encoded URL to get the virus report for.

    Returns:
    dict: The JSON response from the server.
    """
    return make_request(url_id)

def main():
    """
    The main function that parses command-line arguments and performs the requested operation.

    The following command-line arguments are required:
    --url: The URL to be processed.
    --api_key: The API key for VirusTotal.

    The following command-line arguments are optional and perform the associated operation:
    --scan: Scan the URL.
    --rescan: Rescan the URL.
    --get_comments: Get the comments on the URL.
    --add_comment: Add a comment on the URL. Requires --comment_text.
    --get_related_objects: Get the related objects of the URL.
    --get_related_descriptors: Get the related descriptors of the URL.
    --get_virus_report: Get the virus report of the URL.
    
    --comment_text: The comment to be added if --add_comment is used.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("--url", required=True, help="URL to be processed.")
    parser.add_argument("--api_key", required=True, help="API key for VirusTotal.")
    parser.add_argument("--scan", action='store_true', help="Scan the URL.")
    parser.add_argument("--rescan", action='store_true', help="Rescan the URL.")
    parser.add_argument("--get_comments", action='store_true', help="Get comments on the URL.")
    parser.add_argument("--add_comment", action='store_true', help="Add a comment on the URL.")
    parser.add_argument("--get_related_objects", action='store_true', help="Get related objects of the URL.")
    parser.add_argument("--get_related_descriptors", action='store_true', help="Get related descriptors of the URL.")
    parser.add_argument("--get_virus_report", action='store_true', help="Get the virus report of the URL.")
    parser.add_argument("--comment_text", help="The comment to be added if --add_comment is used.")

    args = parser.parse_args()

    global API_KEY
    API_KEY = args.api_key

    try:
        if args.url:
            url_id = get_url_id(args.url)
            if args.scan:
                result = scan_url(url_id)
            elif args.rescan:
                result = rescan_url(url_id)
            elif args.get_comments:
                result = get_comments_on_url(url_id)
            elif args.add_comment:
                if args.comment_text:
                    result = add_comment_on_url(url_id, args.comment_text)
                else:
                    raise ValueError("No comment text provided for --add_comment.")
            elif args.get_related_objects:
                result = get_related_objects(url_id)
            elif args.get_related_descriptors:
                result = get_related_descriptors(url_id)
            elif args.get_virus_report:
                result = get_virus_report(url_id)
            else:
                raise ValueError("No operation selected.")
            print(json.dumps(result, indent=4))
        else:
            raise ValueError("No URL provided.")
    except Exception as e:
        logging.error(f"Error: {e}")

if __name__ == "__main__":
    main()


