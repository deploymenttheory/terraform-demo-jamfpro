"""
This script uses the VirusTotal API to perform various operations on URLs, such as scanning, rescanning, getting comments, adding comments, getting related objects, getting related descriptors, and getting virus reports.

Command-line arguments:
--url: The URL to be processed.
--function: The function to be performed. Can be one of 'scan', 'rescan', 'get_comments', 'add_comment', 'get_related_objects', 'get_related_descriptors', or 'get_virus_report'.
--api_key: The API key for VirusTotal.
--comment_text: The comment to be added if the add_comment function is selected.

Example usage:

python3 analyse_url_with_virus_total.py --url "http://example.com" --function "scan" --api_key "your_api_key"

This will scan the URL "http://example.com" using the VirusTotal API and print the JSON response. Replace "script.py" with the name of this script, "http://example.com" with the URL you want to scan, "scan" with the function you want to perform, and "your_api_key" with your actual API key.

You can also add a comment to a URL like this:

python3 analyse_url_with_virus_total.py --url "http://example.com" --function "add_comment" --api_key "your_api_key" --comment_text "This is a comment."

This will add the comment "This is a comment." to the URL "http://example.com".
"""
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
    error_codes = {
        400: {
            "BadRequestError": "The API request is invalid or malformed. The message usually provides details about why the request is not valid.",
            "InvalidArgumentError": "Some of the provided arguments are incorrect.",
            "NotAvailableYet": "The resource is not available yet, but will become available later.",
            "UnselectiveContentQueryError": "Content search query is not selective enough.",
            "UnsupportedContentQueryError": "Unsupported content search query."
        },
        401: {
            "AuthenticationRequiredError": "The operation requires an authenticated user. Verify that you have provided your API key.",
            "UserNotActiveError": "The user account is not active. Make sure you properly activated your account by following the link sent to your email.",
            "WrongCredentialsError": "The provided API key is incorrect."
        },
        403: {"ForbiddenError": "You are not allowed to perform the requested operation."},
        404: {"NotFoundError": "The requested resource was not found."},
        409: {"AlreadyExistsError": "The resource already exists."},
        424: {"FailedDependencyError": "The request depended on another request and that request failed."},
        429: {
            "QuotaExceededError": "You have exceeded one of your quotas (minute, daily or monthly). Daily quotas are reset every day at 00:00 UTC. You may have run out of disk space and/or number of files on your VirusTotal Monitor account.",
            "TooManyRequestsError": "Too many requests."
        },
        503: {"TransientError": "Transient server error. Retry might work."},
        504: {"DeadlineExceededError": "The operation took too long to complete."}
    }

    status_code = response.status_code
    try:
        error_message = error_codes[status_code][response.json().get('code')]
    except KeyError:
        error_message = "An unknown error occurred."

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

FUNCTION_MAP = {
    'scan': scan_url,
    'rescan': rescan_url,
    'get_comments': get_comments_on_url,
    'add_comment': add_comment_on_url,
    'get_related_objects': get_related_objects,
    'get_related_descriptors': get_related_descriptors,
    'get_virus_report': get_virus_report,
}

def main():
    """
    The main function that parses command-line arguments and performs the requested operation.

    The following command-line arguments are required:
    --url: The URL to be processed.
    --function: The function to be performed. Can be one of 'scan', 'rescan', 'get_comments', 'add_comment', 'get_related_objects', 'get_related_descriptors', or 'get_virus_report'.
    --api_key: The API key for VirusTotal.

    The following command-line argument is optional:
    --comment_text: The comment to be added if the add_comment function is selected.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument("--url", help="URL to be processed.")
    parser.add_argument("--function", choices=list(FUNCTION_MAP.keys()), help="Function to be performed.")
    parser.add_argument("--comment_text", help="Comment to be added if the add_comment function is selected.")
    parser.add_argument("--api_key", required=True, help="API key for VirusTotal.")
    args = parser.parse_args()

    global API_KEY
    API_KEY = args.api_key

    try:
        if args.url:
            url_id = get_url_id(args.url)
            function = FUNCTION_MAP[args.function]
            if args.function == 'add_comment':
                if args.comment_text:
                    result = function(url_id, args.comment_text)
                else:
                    raise ValueError("No comment text provided for add_comment function.")
            else:
                result = function(url_id)
            print(json.dumps(result, indent=4))
        else:
            raise ValueError("No URL provided.")
    except Exception as e:
        logging.error(f"Error: {e}")

if __name__ == "__main__":
    main()


