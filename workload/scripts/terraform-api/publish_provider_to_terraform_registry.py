import requests
import json
import re

# Terraform Cloud API token
terraform_token = "AQK7lhTYnzcTKg.atlasv1.hrWv0jkS8On4gLUkWQn4Y67gwDrZuDLJQ8ZZCyZGmt10uYXBR1JzuXkPT20ifa9ASMw"

# GitHub API token
github_token = "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"

# Organization and provider details
organization = "deploymenttheory"
provider_name = "jamf"
version = "10.48.0"

# GitHub repository details and paths to the files
github_repo = "deploymenttheory/terraform-provider-jamf"

# GPG signing key
public_gpg_key = "<public-gpg-key>"

terraform_headers = {
    "Authorization": "Bearer " + terraform_token,
    "Content-Type": "application/vnd.api+json",
}

github_headers = {
    "Authorization": "token " + github_token,
}

# Use the GitHub API to get the release by tag
url = f"https://api.github.com/repos/{github_repo}/releases/tags/{version}"
response = requests.get(url, headers=github_headers)
assets = response.json()["assets"]

# Download an asset from GitHub
def download_asset(asset_url):
    response = requests.get(asset_url, headers=github_headers)
    return response.content

# Create a provider
url = f"https://app.terraform.io/api/v2/organizations/{organization}/registry-providers"
data = {
    "data": {
        "type": "registry-providers",
        "attributes": {
            "name": provider_name,
        }
    }
}
response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
print("Provider created.")

# Add a GPG key
url = f"https://app.terraform.io/api/v2/organizations/{organization}/gpg-keys"
data = {
    "data": {
        "type": "gpg-keys",
        "attributes": {
            "key": public_gpg_key,
        }
    }
}
response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
key_id = response.json()["data"]["id"]
print("GPG key added.")

# Create a provider version
url = f"https://app.terraform.io/api/v2/registry-providers/{provider_name}/versions"
data = {
    "data": {
        "type": "registry-provider-versions",
        "attributes": {
            "version": version,
            "gpg-key-id": key_id,
        }
    }
}
response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
shasums_upload_url = response.json()["data"]["links"]["shasums-upload"]
shasums_sig_upload_url = response.json()["data"]["links"]["shasums-sig-upload"]
print("Provider version created.")

# Upload SHA256SUMS and SHA256SUMS.sig
for asset in assets:
    if asset["name"].endswith("_SHA256SUMS"):
        sha256sums = download_asset(asset["browser_download_url"])
        requests.put(shasums_upload_url, headers={"Content-Type": "application/octet-stream"}, data=sha256sums)
        print("SHA256SUMS uploaded.")
    elif asset["name"].endswith("_SHA256SUMS.sig"):
        sha256sums_sig = download_asset(asset["browser_download_url"])
        requests.put(shasums_sig_upload_url, headers={"Content-Type": "application/octet-stream"}, data=sha256sums_sig)
        print("SHA256SUMS.sig uploaded.")

# Upload all provider binaries
for asset in assets:
    if asset["name"].endswith(".zip"):
        os_name, arch_name = re.findall(r"_(\w+)_", asset["name"])
        provider_binary = download_asset(asset["browser_download_url"])
        url = f"https://app.terraform.io/api/v2/registry-provider-versions/{version}/platforms"
        data = {
            "data": {
                "type": "registry-provider-platforms",
                "attributes": {
                    "os": os_name,
                    "arch": arch_name,
                }
            }
        }
        response = requests.post(url, headers=terraform_headers, data=json.dumps(data))
        provider_binary_upload_url = response.json()["data"]["links"]["provider-binary-upload"]
        requests.put(provider_binary_upload_url, headers={"Content-Type": "application/octet-stream"}, data=provider_binary)
        print(f"Provider binary for {os_name} {arch_name} uploaded.")
