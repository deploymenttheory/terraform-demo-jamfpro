"""
Script to Create a Provider Version endpoint in Terraform Cloudpip Private Registry using Terraform Cloud API.

This script takes command-line arguments for the access token, organization name, private registry name,
namespace, provider name, version, GPG key ID, and supported Terraform provider API versions.
It then makes a POST request to create a new provider version in the specified private registry.

Usage:
python create_provider_version_script.py --token YOUR_ACCESS_TOKEN --organization_name hashicorp --registry_name private --namespace hashicorp --name aws --version 3.1.1 --key_id 32966F3FB5AC1129 --protocols 5.0

Arguments:
--token              Access token for authentication.
--organization_name  Name of the organization.
--registry_name      Name of the private registry.
--namespace          Namespace of the provider.
--name               Name of the provider.
--version            Version of the provider to create.
--key_id             GPG key ID.
--protocols          Terraform provider API versions supported (e.g., 5.0).

Example:
python create_provider_version_script.py --token YOUR_ACCESS_TOKEN --organization_name hashicorp --registry_name private --namespace hashicorp --name aws --version 3.1.1 --key_id 32966F3FB5AC1129 --protocols 5.0
"""

import argparse
import requests

def create_provider_version(token, organization_name, registry_name, namespace, name, version, key_id, protocols):
    url = f"https://app.terraform.io/api/v2/organizations/{organization_name}/registry-providers/{registry_name}/{namespace}/{name}/versions"

    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/vnd.api+json"
    }

    payload = {
        "data": {
            "type": "registry-provider-versions",
            "attributes": {
                "version": version,
                "key-id": key_id,
                "protocols": protocols
            }
        }
    }

    response = requests.post(url, headers=headers, json=payload)

    if response.status_code == 201:
        print("Provider version created successfully!")
        data = response.json()
        version_id = data["data"]["id"]
        print(f"Version ID: {version_id}")
    else:
        print(f"Failed to create provider version. Status code: {response.status_code}")
        print(response.text)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create a provider version in a private registry.")
    parser.add_argument("--token", required=True, help="Access token for authentication.")
    parser.add_argument("--organization_name", required=True, help="Name of the organization.")
    parser.add_argument("--registry_name", required=True, help="Name of the private registry.")
    parser.add_argument("--namespace", required=True, help="Namespace of the provider.")
    parser.add_argument("--name", required=True, help="Name of the provider.")
    parser.add_argument("--version", required=True, help="Version of the provider to create.")
    parser.add_argument("--key_id", required=True, help="GPG key ID.")
    parser.add_argument("--protocols", nargs="+", required=True, help="Terraform provider API versions supported (e.g., 5.0).")
    args = parser.parse_args()

    create_provider_version(args.token, args.organization_name, args.registry_name, args.namespace,
                            args.name, args.version, args.key_id, args.protocols)
