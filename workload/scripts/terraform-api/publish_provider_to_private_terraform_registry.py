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

# Error handling function
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
url = f"https://api.github.com/repos/{github_repo}/releases/tags/{version}"
response = requests.get(url, headers=github_headers)
handle_response(response)
assets = response.json()["assets"]

# Download an asset from GitHub
def download_asset(asset_url):
    response = requests.get(asset_url, headers=github_headers)
    handle_response(response)
    content = response.content
    decoded_content = None
    if "text" in response.headers.get("Content-Type", ""):
        decoded_content = content.decode("utf-8")  # Decode the content if it's text
    return content, decoded_content




# Create a provider
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


# If the GPG key already exists, retrieve the existing one
if response.status_code == 400 and "GPG key already exists for namespace" in response.text:
    print("GPG key already exists for namespace. Retrieving the existing key.")
    response = requests.get(url, headers=terraform_headers, params={"filter[namespace]": organization})
    handle_response(response)
    keys = response.json()["data"]
    for key in keys:
        if key["attributes"]["namespace"] == organization and key["attributes"]["ascii-armor"] == public_gpg_key:
            key_id = key["id"]
            break
    else:
        print("No matching GPG key found.")
        exit(1)
else:
    handle_response(response)
    key_id = response.json()["data"]["id"]

print("GPG key added.")



# Create a provider version
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

try:
    response = requests.post(url, headers=terraform_headers, data=json.dumps(data), timeout=30)
    response.raise_for_status()

    json_data = response.json()

    if 'data' not in json_data:
        print("The response does not contain expected 'data' field.")
        sys.exit(1)

    if 'links' not in json_data['data']:
        print("The 'data' field in the response does not contain expected 'links' field.")
        sys.exit(1)

    sha256sums_upload_url = json_data["data"]["links"].get("shasums-upload")
    if not sha256sums_upload_url:
        print("The 'links' field in the response does not contain 'shasums-upload' URL.")
        sys.exit(1)

    sha256sums_sig_upload_url = json_data["data"]["links"].get("shasums-sig-upload")
    if not sha256sums_sig_upload_url:
        print("The 'links' field in the response does not contain 'shasums-sig-upload' URL.")
        sys.exit(1)

    print("Provider version created.")

    # Download SHA256SUMS and SHA256SUMS.sig from GitHub
    sha256sums = None
    sha256sums_sig = None
    for asset in assets:
        if asset["name"].endswith("_SHA256SUMS"):
            sha256sums, sha256sums_decoded = download_asset(asset["browser_download_url"])
        elif asset["name"].endswith("_SHA256SUMS.sig"):
            sha256sums_sig, _ = download_asset(asset["browser_download_url"])

    if not sha256sums or not sha256sums_sig:
        print("SHA256SUMS and/or SHA256SUMS.sig file not found.")
        sys.exit(1)

    # Check if SHA256SUMS decoding was successful
    if not sha256sums_decoded:
        print("Failed to download or decode SHA256SUMS file.")
        sys.exit(1)

    # Upload SHA256SUMS and SHA256SUMS.sig
    response = requests.put(sha256sums_upload_url, headers={"Content-Type": "application/octet-stream"}, data=sha256sums)
    handle_response(response)
    print("SHA256SUMS uploaded.")

    response = requests.put(sha256sums_sig_upload_url, headers={"Content-Type": "application/octet-stream"}, data=sha256sums_sig)
    handle_response(response)
    print("SHA256SUMS.sig uploaded.")

except requests.exceptions.HTTPError as http_err:
    print(f'HTTP error occurred: {http_err}')
    print(f'Response content: {response.content}')

except requests.exceptions.RequestException as req_err:
    print(f'Request error occurred: {req_err}')

except json.JSONDecodeError as json_err:
    print(f'JSON decode error occurred: {json_err}')

except Exception as e:
    print(f'An error occurred: {e}')

# Use the GitHub API to get the SHA256SUMS and SHA256SUMS.sig URLs
sha256sums_url = None
sha256sums_sig_url = None
for asset in assets:
    if asset["name"].endswith("_SHA256SUMS"):
        sha256sums_url = asset["browser_download_url"]
    elif asset["name"].endswith("_SHA256SUMS.sig"):
        sha256sums_sig_url = asset["browser_download_url"]

if not sha256sums_url or not sha256sums_sig_url:
    print("SHA256SUMS and/or SHA256SUMS.sig file URLs not found.")
    sys.exit(1)


# Download SHA256SUMS from GitHub
sha256sums, sha256sums_decoded = download_asset(sha256sums_url)

# Check if SHA256SUMS decoding was successful
if not sha256sums_decoded:
    print("Failed to download or decode SHA256SUMS file.")
    sys.exit(1)

# Parse SHA256SUMS to get the file names and shasums
shasums_dict = {}
for line in sha256sums_decoded.split("\n"):
    parts = line.split("  ")
    if len(parts) == 2:
        filename, shasum = parts[1], parts[0]
        shasums_dict[filename] = shasum

# Download and upload each provider binary
for asset in assets:
    if asset["name"].endswith(".zip"):
        os_name, arch_name = re.findall(r"_(\w+)_", asset["name"])
        filename = asset["name"]
        shasum = shasums_dict.get(filename)

        if not shasum:
            print(f"File {filename} not found in SHA256SUMS or has an invalid entry. Skipping download and upload.")
            continue

        provider_binary, _ = download_asset(asset["browser_download_url"])

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

        try:
            # Create the platform
            response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
            response_json = response.json()

            if response.status_code == 201:
                provider_binary_upload_url = response_json["data"]["links"]["provider-binary-upload"]
                response = requests.put(provider_binary_upload_url, headers={"Content-Type": "application/octet-stream"}, data=provider_binary)

                if response.status_code == 200:
                    print(f"Provider binary for {os_name} {arch_name} uploaded.")
                else:
                    print(f"Failed to upload provider binary for {os_name} {arch_name}. Status code: {response.status_code}")
                    print(f"Response content: {response.content}")
                    # Additional error handling, if needed

            else:
                print(f"Failed to create platform for {os_name} {arch_name}. Status code: {response.status_code}")
                print(f"Response content: {response.content}")
                # Additional error handling, if needed

        except requests.exceptions.RequestException as req_err:
            print(f'Request error occurred while creating platform: {req_err}')

        except json.JSONDecodeError as json_err:
            print(f'JSON decode error occurred while creating platform: {json_err}')

        except Exception as e:
            print(f'An error occurred while creating platform: {e}')

