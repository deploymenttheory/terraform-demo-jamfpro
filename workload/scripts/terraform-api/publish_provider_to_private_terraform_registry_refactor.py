'''
Get the release from GitHub using the specified tag.
Create a provider in Terraform's registry.
Get the GPG key ID if one exists, or add a new GPG key if it doesn't.
Create a provider version in Terraform's registry.
Download the SHA256SUMS and SHA256SUMS.sig files from the GitHub release and parse the SHA256SUMS to get the SHA-256 hashes of the other files in the release.
Download the .zip files (the platform binaries) from the GitHub release.
Upload the SHA256SUMS and SHA256SUMS.sig files to Terraform's registry.
Create a platform for each .zip file in the GitHub release, skipping any files where the filename format is unexpected or where the SHA-256 hash of the downloaded file does not match the hash in the SHA256SUMS file.
Upload the .zip files (the platform binaries) to Terraform's registry.
If there are any errors during the HTTP requests, the script will print an error message and exit. If a file cannot be downloaded or the SHA-256 hash of a downloaded file does not match the expected hash, the script will print a warning message and skip that file.
'''

import requests
import json
import re
import hashlib

# Terraform Cloud API token
terraform_token = "9EujQ50Ybc3GSQ.atlasv1.S3zPYcoTUTeW3ZLs75oaAQykghDTZbqebLGhUTMb2fgN9xaT9tkg0mk1nAM3IDEbFs8"

# GitHub API tokengpg --armor --export 3AA5C34371567BD2
github_token = "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"

# Organization details for github and for terraform
tf_organization = "deploymenttheory"

# terraform provider name
provider_name = "jamfpro"

# GitHub repository details and paths to the files
github_repo = "terraform-provider-jamfpro"
github_organization = "deploymenttheory"

# release version. used for github release tag lookup and up terraform provider upload.
version = "10.48.0"


#github_repo = "deploymenttheory/terraform-provider-jamfpro"

# GPG signing key (ASCII-armored representation of a public GPG key)
public_gpg_key = """
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBGTI3AwBEAC2mQz8VZjj32CT/OALz4RxIGFwfMz0zdMLrZ6c5jTV8MQ17IAC
A6mpkapLEIKKTrRuG2ZgBzYvf4wSPYwuFC2FtzF1aFZ9JKrpdZ1CsBOxHxoQ0cQc
neaC4RJi0a23Oxj9JavFy+En07OQ09SVLfmYLdHPkE/Ex+VQPeCPODwTEhY4lh3E
XtY/mZLLyhRwjwPlDRnkM58woU90ZpXlb6AhGg92cQ62lpWraSlyzECfkcpmPPsg
4KC1ECKCXnWVxRgbexs29lIDLP7FFU7p0L08Aen+Ft5LmP4ZzCtQRAtxUab3zU4b
4OmXoGnFi05NeTliOmkQc3Ud9yuelq6+siq6Z6POzzhxxa2SlSZYgyhB/bLmHMDq
Y3lNCajo+gc6t0Y1+koQGXG77lt1SUXuOU3wj0GxbW0cdGj1rXsyFb8ICOmTQxsC
E5XUuAEvFMVpwV+6w0yfNbMogEbt5s4L7KmP0Tmj9NE0amwbZEAi7vL6bJI7Eg2J
TffezB6MdNidgoj2J7Ddxvtq8zcCXEh4H3M/JE4UZ90xKHi93Mi77MHpndLIOhsE
U0ycmffgaZekn4e9rdBwWC2rkYBhmHpBRj9CqO/zp6AKJUqXLcb4WVGgHOcwb4it
7QPU4CuE5tICUN4AaQnQaFHaDAsixBhh9jKFpRle9F4av/uKBIDmUcB49QARAQAB
tDVEYWZ5ZGQgV2F0a2lucyA8YWRtaW5fZC53YXRraW5zQGRlcGxveW1lbnR0aGVv
cnkuY29tPokCVAQTAQgAPhYhBMyY7iv8nTWED4Xa35yH97GhtsGVBQJkyNwMAhsD
BQkDwmcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEJyH97GhtsGVjqoQAIzg
m/Ilr2WJbOLjAAWTTizouVZdK7B/6GYIsbGrcwY693Ozlcfd02bVLfBDYvlauOgW
8fw1tibOlKQJ7J3GQZM/Z5czUGy5ADmmXKtwv/9ThBUgDOwdM31Grk1wvDlWsn+s
Vu6OyMEjhAvQVjtoZZdXRBGqCj+yWm9cHn3T3Vk2qpcpHMJz0eic1oB80aRJ7bLO
noPYdgWlfOlA/8dsuJtxtDL+6GJuMtjlxMSaQggiEXUUX0AZkpJzoJvL4t4lJB8R
cqRljhtjzou0Cj93B0SztsTF+baLPCobn3TAb1yzZH7RIS9vTePUkxdpT1L5gVAd
Fca7MGVVyP6bFFrznK1uq/mEqQPbXMf4HHZsPPNbWlVfh7E9tWc6yftg7Myd8/uN
k7Kn5GEbTa2ykPYqUdTMkVJrBLstzRoBvE9qQzVvNBP2iOyyRIcsTs0rXed5uPBl
l9+YQt4+scxnxDeOyan/foGnTWXzSui7MwQBvWEZNQxvEYv4JwZzEgV57441//IT
0A25sMPfJiVDspCyG6hyb/+4BE5Y7yHlwW6XNgEGEF6J4syJZK/Go4z/6gK3zxwT
AtcjLY8YQR3SKY6vFLNOBc/qcOwSVSqsmOrGNDrloT3YDseQlfcSD/A18UwawFzm
Mc1vA19bJnQGTjK0YOYeBaquWiNvcvu5ad0UV/ln
=nxAY
-----END PGP PUBLIC KEY BLOCK-----
"""

terraform_headers = {
    "Authorization": "Bearer " + terraform_token,
    "Content-Type": "application/vnd.api+json",
}

github_headers = {
    "Authorization": "token " + github_token,
}

# Error Handling Function
def handle_response(response, skip_gpg_error=False):
    try:
        response.raise_for_status()
    except requests.exceptions.HTTPError as err:
        if skip_gpg_error and "GPG key already exists for namespace" in response.text:
            print("Skipping GPG key creation: GPG key already exists for namespace.")
        else:
            print(f"HTTP error occurred: {err}")
            print(f"Response headers: {response.headers}")
            print(f"Response content: {response.content}")
            print(response.text)  # print the response body
            exit(1)

# Use the GitHub API to get the release by tag
def get_release_by_tag():
    url = f"https://api.github.com/repos/{github_organization}/{github_repo}/releases/tags/v{version}"
    response = requests.get(url, headers=github_headers)
    handle_response(response)
    assets = response.json()["assets"]
    for asset in assets:
        print(f"GitHub Release contains asset: {asset['name']}")
    return assets


# Create a Provider
def create_provider():
    url = f"https://app.terraform.io/api/v2/organizations/{tf_organization}/registry-providers"
    data = {
        "data": {
            "type": "registry-providers",
            "attributes": {
                "name": provider_name,
                "namespace": tf_organization,
                "registry-name": "private"
            }
        }
    }
    response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
    if "Name has already been taken" in response.text:
        print("Provider with this name already exists in the namespace. Skipping provider creation.")
    else:
        handle_response(response)
        print("Terraform Provider created.")

# Get gpg key id if one already exists.
def get_gpg_keys():
    url = f"https://app.terraform.io/api/registry/private/v2/gpg-keys?filter%5Bnamespace%5D={tf_organization}"
    response = requests.get(url, headers=terraform_headers)
    handle_response(response)

    gpg_keys = response.json()["data"]
    for gpg_key in gpg_keys:
        if gpg_key["attributes"]["namespace"] == tf_organization:
            return gpg_key["attributes"]["key-id"]

    return None


# Add a GPG key
def add_gpg_key():
    url = f"https://app.terraform.io/api/registry/private/v2/gpg-keys"
    data = {
        "data": {
            "type": "gpg-keys",
            "attributes": {
                "namespace": tf_organization,
                "ascii-armor": public_gpg_key,
            }
        }
    }
    response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
    handle_response(response, skip_gpg_error=True)
    response_json = response.json()
    if 'errors' in response_json:
        print("GPG key already exists, skipping...")
        return None
    elif 'data' in response_json:
        key_id = response_json["data"]["id"]
        print("GPG key added.")
        return key_id
    else:
        print("Unexpected response when adding GPG key: ", response_json)
        exit(1)


# Create a Provider Version
def create_provider_version(key_id):
    url = f"https://app.terraform.io/api/v2/organizations/{tf_organization}/registry-providers/private/{tf_organization}/{provider_name}/versions"
    data = {
        "data": {
            "type": "registry-provider-versions",
            "attributes": {
                "version": version,
                "protocols": ["5.0"]
            }
        }
    }
    if key_id is not None:
        data["data"]["attributes"]["key-id"] = key_id
    response = requests.post(url, headers=terraform_headers, data=json.dumps(data), timeout=30)
    handle_response(response)
    print("Provider version created.")
    return response.json()["data"]["links"]["shasums-upload"], response.json()["data"]["links"]["shasums-sig-upload"]

# Dictionary to store downloaded files
downloaded_files = {}

# Download an asset from GitHub
def download_asset(asset_url):
    print(f"Downloading asset from URL: {asset_url}")
    response = requests.get(asset_url, headers=github_headers)
    handle_response(response)
    content = response.content
    # Add the content to the downloaded_files dictionary
    downloaded_files[asset_url.split('/')[-1]] = content
    decoded_content = None
    # Parse SHA256SUMS from release for all release file names
    if asset_url.endswith("_SHA256SUMS"):
        try:
            decoded_content = content.decode("utf-8")
        except Exception as e:
            print(f"Error decoding asset: {str(e)}")
    return content, decoded_content


# Download SHA256SUMS and SHA256SUMS.sig. parse SHA256SUMS to get the file names and shasums and put them into a dictionary
def download_sha256sums_and_sig(assets):
    sha256sums = None
    sha256sums_sig = None
    sha256sums_dict = None

    for asset in assets:
        if asset["name"] == f"{github_repo}_{version}_SHA256SUMS":
            sha256sums, sha256sums_decoded = download_asset(asset["browser_download_url"])
            if isinstance(sha256sums_decoded, str) and "Error" in sha256sums_decoded:
                print(sha256sums_decoded)
                exit(1)
            sha256sums_dict = dict(re.findall(r"(\S+)\s+(.*)", sha256sums_decoded))
        elif asset["name"] == f"{github_repo}_{version}_SHA256SUMS.sig":
            sha256sums_sig, _ = download_asset(asset["browser_download_url"])

    if sha256sums is None or sha256sums_dict is None:
        print("SHA256SUMS file not found in the release assets.")
        exit(1)

    if sha256sums_sig is None:
        print("SHA256SUMS.sig file not found in the release assets.")
        exit(1)

    # Print the contents of sha256sums_dict
    print("#-----------------------------------------------------------#")
    print("Contents of sha256sums_dict:")
    for k, v in sha256sums_dict.items():
        print(f"{k}: {v}")

    return sha256sums, sha256sums_sig, sha256sums_dict


# Download zip assets from GitHub
def download_zip_assets(assets):
    for asset in assets:
        if asset["name"].endswith(".zip"):
            download_asset(asset["browser_download_url"])


# Upload SHA256SUMS and SHA256SUMS.sig
def upload_sha256sums_and_sig(sha256sums, sha256sums_sig, sha256sums_upload_url, sha256sums_sig_upload_url):
    print(f"SHA256SUMS upload URL: {sha256sums_upload_url}")
    print(f"SHA256SUMS.sig upload URL: {sha256sums_sig_upload_url}")

    response = requests.put(sha256sums_upload_url, headers={"Content-Type": "application/octet-stream"}, data=sha256sums)
    handle_response(response)
    print("SHA256SUMS uploaded.")
    response = requests.put(sha256sums_sig_upload_url, headers={"Content-Type": "application/octet-stream"}, data=sha256sums_sig)
    handle_response(response)
    print("SHA256SUMS.sig uploaded.")


# Create a Provider Platform
def create_provider_platform(sha256sums_dict, assets):
    platform_upload_urls = {}
    # Iterate over each asset (binary file)
    for asset in assets:
        # We are interested in the .zip files
        if asset["name"].endswith(".zip"):
            # Extract os_name and arch_name from the filename
            os_match = re.search(r".*_(\w+)_.*\.zip$", asset["name"])
            arch_match = re.search(r".*_.*_(\w+)\.zip$", asset["name"])
            if os_match is None or arch_match is None:
                print(f"Unexpected filename format for {asset['name']}, skipping...")
                print("Failed regex: " + r".*_(\w+)_.*\.zip$" + " or " + r".*_.*_(\w+)\.zip$")
                continue
            os_name = os_match.group(1)
            arch_name = arch_match.group(1)

            filename = asset["name"]

            # Calculate the SHA-256 hash of the downloaded file
            downloaded_file = downloaded_files.get(filename)
            if downloaded_file is None:
                print(f"No downloaded file found for {filename}, skipping platform creation.")
                continue

            calculated_sha256_hash = hashlib.sha256(downloaded_file).hexdigest()

            # Get the expected SHA-256 hash from the SHA256SUMS file
            expected_sha256_hash = sha256sums_dict.get(filename)

            # If the expected SHA-256 hash is not found in the SHA256SUMS file, print a warning message and continue with the next asset
            if not expected_sha256_hash:
                print(f"File {filename} not found in SHA256SUMS. Skipping platform creation.")
                continue

            # If the calculated hash does not match the expected hash, print a warning message and continue with the next asset
            if calculated_sha256_hash != expected_sha256_hash:
                print(f"SHA-256 hash mismatch for {filename}. Expected: {expected_sha256_hash}, Calculated: {calculated_sha256_hash}. Skipping platform creation.")
                continue

            # Define the request URL and data
            url = f"https://app.terraform.io/api/v2/organizations/{tf_organization}/registry-providers/private/{tf_organization}/{provider_name}/versions/{version}/platforms"
            data = {
                "data": {
                    "type": "registry-provider-platforms",
                    "attributes": {
                        "os": os_name,
                        "arch": arch_name,
                        "shasum": expected_sha256_hash,
                        "filename": filename
                    }
                }
            }
            # Send a POST request to create the platform
            response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
            handle_response(response)
            print(f"Platform for {os_name} {arch_name} created.")
            platform_upload_urls[filename] = response.json()["data"]["links"]["provider-binary-upload"]
    return platform_upload_urls


# Upload Platform Binary
def upload_platform_binary(assets, platform_upload_urls):
    # Print overview of downloaded files
    print("#-----------------------------------------------------------#")
    print("Files in memory:")
    for filename, content in downloaded_files.items():
        print(f"{filename}: {len(content)} bytes")

    # Iterate over each asset (binary file)
    for asset in assets:
        # We are interested in the .zip files
        if asset["name"].endswith(".zip"):
            # Get the binary file from the downloaded_files dictionary
            binary_file = downloaded_files.get(asset["name"])
            if binary_file is None:
                print(f"No downloaded file found for {asset['name']}, skipping...")
                continue

            # Get the correct upload URL for this platform
            platform_binary_upload_url = platform_upload_urls.get(asset["name"])
            if not platform_binary_upload_url:
                print(f"No upload URL found for {asset['name']}, skipping...")
                continue

            # Print the URL before uploading the binary file
            print(f"Uploading {asset['name']} to URL: {platform_binary_upload_url}")

            # Upload the binary file to the platform_binary_upload_url
            response = requests.put(platform_binary_upload_url, headers={"Content-Type": "application/octet-stream"}, data=binary_file)
            handle_response(response)
            print(f"Binary file {asset['name']} uploaded.")



def main():
    assets = get_release_by_tag()
    create_provider()

    key_id = get_gpg_keys()  # First, try to get the existing GPG key ID
    if key_id is None:  # If no key ID is found, then create a new GPG key
        key_id = add_gpg_key()

    sha256sums_upload_url, sha256sums_sig_upload_url = create_provider_version(key_id)
    
    sha256sums, sha256sums_sig, sha256sums_dict = download_sha256sums_and_sig(assets)
    download_zip_assets(assets)  # Download zip files

    upload_sha256sums_and_sig(sha256sums, sha256sums_sig, sha256sums_upload_url, sha256sums_sig_upload_url)
    
    platform_upload_urls = create_provider_platform(sha256sums_dict, assets)
    
    upload_platform_binary(assets, platform_upload_urls)

if __name__ == "__main__":
    main()
