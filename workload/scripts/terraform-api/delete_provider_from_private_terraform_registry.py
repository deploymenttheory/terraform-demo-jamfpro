import requests
import json

# Terraform Cloud API token
terraform_token = "3MuM9yPtymjI8g.atlasv1.dO9bsLOJhFaRM3Org1lX1ZJmyjbkxMeHzjCLAkwJSQlJm7PpqAtdzOgDQPlbL6Faze0"

# Organization and provider details
organization = "deploymenttheory"
provider_name = "jamfpro"

terraform_headers = {
    "Authorization": "Bearer " + terraform_token,
    "Content-Type": "application/vnd.api+json",
}

# Error handling function
def handle_response(response):
    try:
        response.raise_for_status()
    except requests.exceptions.HTTPError as err:
        print(f"HTTP request failed: {err}")
        exit(1)

# Delete a provider
url = f"https://app.terraform.io/api/v2/organizations/{organization}/registry-providers/private/{organization}/{provider_name}"
response = requests.delete(url, headers=terraform_headers)
handle_response(response)
print("Provider deleted.")
