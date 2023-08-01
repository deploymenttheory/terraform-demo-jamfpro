import requests
import json
import re
import sys

# Terraform Cloud API token
terraform_token = "9EujQ50Ybc3GSQ.atlasv1.S3zPYcoTUTeW3ZLs75oaAQykghDTZbqebLGhUTMb2fgN9xaT9tkg0mk1nAM3IDEbFs8"

# GitHub API tokengpg --armor --export 3AA5C34371567BD2
github_token = "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"

# Organization and provider details
organization = "deploymenttheory"
provider_name = "jamfpro"
version = "v10.48.0"

# GitHub repository details and paths to the files
github_repo = "deploymenttheory/terraform-provider-jamfpro"

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
    url = f"https://api.github.com/repos/{github_repo}/releases/tags/{version}"
    response = requests.get(url, headers=github_headers)
    handle_response(response)
    return response.json()["assets"]

# Create a Provider
def create_provider():
    url = f"https://app.terraform.io/api/v2/organizations/{organization}/registry-providers"
    data = {
        "data": {
            "type": "registry-providers",
            "attributes": {
                "name": provider_name,
                "namespace": organization,
                "registry-name": "private"
            }
        }
    }
    response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
    handle_response(response)
    print("Provider created.")

# Add a GPG key
def add_gpg_key():
    url = f"https://app.terraform.io/api/registry/private/v2/gpg-keys"
    data = {
        "data": {
            "type": "gpg-keys",
            "attributes": {
                "namespace": organization,
                "ascii-armor": public_gpg_key,
            }
        }
    }
    response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
    handle_response(response, skip_gpg_error=True)
    response_json = response.json()
    if 'data' in response_json:
        key_id = response_json["data"]["id"]
        print("GPG key added.")
        return key_id
    else:
        print("Unexpected response when adding GPG key: ", response_json)
        exit(1)


# Create a Provider Version
def create_provider_version(key_id):
    url = f"https://app.terraform.io/api/v2/organizations/{organization}/registry-providers/private/{organization}/{provider_name}/versions"
    data = {
        "data": {
            "type": "registry-provider-versions",
            "attributes": {
                "version": version,
                "key-id": key_id,
                "protocols": ["5.0"]
            }
        }
    }
    response = requests.post(url, headers=terraform_headers, data=json.dumps(data), timeout=30)
    handle_response(response)
    print("Provider version created.")
    return response.json()["data"]["links"]["shasums-upload"], response.json()["data"]["links"]["shasums-sig-upload"]

# Download an asset from GitHub
def download_asset(asset_url):
    response = requests.get(asset_url, headers=github_headers)
    handle_response(response)
    content = response.content
    decoded_content = None
    if "text" in response.headers.get("Content-Type", ""):
        decoded_content = content.decode("utf-8")  # Decode the content if it's text
    return content, decoded_content

# Download and parse SHA256SUMS to get the file names and shasums
def download_and_parse_sha256sums(assets):
    for asset in assets:
        if asset["name"] == "SHA256SUMS":
            sha256sums, sha256sums_decoded = download_asset(asset["browser_download_url"])
            break
    else:
        print("SHA256SUMS file not found in the release assets.")
        exit(1)

    shasums_dict = dict(re.findall(r"(\w+)\s+(\w+_\w+_\w+\.zip)", sha256sums_decoded))
    return sha256sums, sha256sums_decoded, shasums_dict

# Upload SHA256SUMS and SHA256SUMS.sig
def upload_sha256sums_and_sig(sha256sums_upload_url, sha256sums_sig_upload_url):
    sha256sums, _ = download_asset(sha256sums_upload_url)
    sha256sums_sig, _ = download_asset(sha256sums_sig_upload_url)
    response = requests.put(sha256sums_upload_url, headers={"Content-Type": "application/octet-stream"}, data=sha256sums)
    handle_response(response)
    print("SHA256SUMS uploaded.")
    response = requests.put(sha256sums_sig_upload_url, headers={"Content-Type": "application/octet-stream"}, data=sha256sums_sig)
    handle_response(response)
    print("SHA256SUMS.sig uploaded.")

# Create a Provider Platform
def create_provider_platform(shasums_dict, assets):
    # Iterate over each asset (binary file)
    for asset in assets:
        # We are interested in the .zip files
        if asset["name"].endswith(".zip"):
            # Extract os_name and arch_name from the filename
            os_name, arch_name = re.findall(r"_(\w+)_", asset["name"])
            filename = asset["name"]
            shasum = shasums_dict.get(filename)

            # If shasum is not found, print a warning message and continue with the next asset
            if not shasum:
                print(f"File {filename} not found in SHA256SUMS or has an invalid entry. Skipping platform creation.")
                continue

            # Define the request URL and data
            url = f"https://app.terraform.io/api/v2/organizations/{organization}/registry-providers/private/{organization}/{provider_name}/versions/{version}/platforms"
            data = {
                "data": {
                    "type": "registry-provider-platforms",
                    "attributes": {
                        "os": os_name,
                        "arch": arch_name,
                        "shasum": shasum,
                        "filename": filename
                    }
                }
            }
            # Send a POST request to create the platform
            response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
            handle_response(response)
            print(f"Platform for {os_name} {arch_name} created.")
            return response.json()["data"]["links"]["provider-binary-upload"]

# Upload Platform Binary
def upload_platform_binary(platform_binary_upload_url, assets):
    # Iterate over each asset (binary file)
    for asset in assets:
        # We are interested in the .zip files
        if asset["name"].endswith(".zip"):
            # Download the binary file from GitHub
            binary_file, _ = download_asset(asset["browser_download_url"])
            # Upload the binary file to the platform_binary_upload_url
            response = requests.put(platform_binary_upload_url, headers={"Content-Type": "application/octet-stream"}, data=binary_file)
            handle_response(response)
            print(f"Binary file {asset['name']} uploaded.")


def main():
    assets = get_release_by_tag()
    create_provider()
    key_id = add_gpg_key()
    sha256sums_upload_url, sha256sums_sig_upload_url = create_provider_version(key_id)
    upload_sha256sums_and_sig(sha256sums_upload_url, sha256sums_sig_upload_url)
    shasums_dict = download_and_parse_sha256sums(assets)
    platform_binary_upload_url = create_provider_platform(shasums_dict, assets)
    upload_platform_binary(platform_binary_upload_url, assets)

if __name__ == "__main__":
    main()
