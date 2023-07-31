"""
Script to Add a PGP Key to a Private Registry using Terraform Cloud API.

This script takes command-line arguments for the access token, private registry name,
namespace, and the path to a file containing the PGP key. It then makes a POST request
to upload the PGP key to the specified private registry.

Usage:
python add_pgp_key_script.py --token YOUR_ACCESS_TOKEN --private_registry_name private --namespace your-organization --pgp_key_path pgp_key.txt

Arguments:
--token                 Access token for authentication.
--private_registry_name Name of the private registry.
--namespace             Namespace for the PGP key.
--pgp_key_path          Path to the file containing the PGP key.

Example:
python add_pgp_key_script.py --token YOUR_ACCESS_TOKEN --private_registry_name private --namespace your-organization --pgp_key_path pgp_key.txt
"""

import argparse
import requests

def add_pgp_key(token, private_registry_name, namespace, pgp_key_path):
    with open(pgp_key_path, "r") as file:
        pgp_key = file.read()

    url = f"https://app.terraform.io/api/registry/{private_registry_name}/v2/gpg-keys"

    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/vnd.api+json"
    }

    payload = {
        "data": {
            "type": "gpg-keys",
            "attributes": {
                "namespace": namespace,
                "ascii-armor": pgp_key
            }
        }
    }

    response = requests.post(url, headers=headers, json=payload)

    if response.status_code == 201:
        print("PGP key added successfully!")
        data = response.json()
        key_id = data["data"]["id"]
        print(f"Key ID: {key_id}")
    else:
        print(f"Failed to add PGP key. Status code: {response.status_code}")
        print(response.text)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Add a PGP key to a private registry.")
    parser.add_argument("--token", required=True, help="Access token for authentication.")
    parser.add_argument("--private_registry_name", required=True, help="Name of the private registry.")
    parser.add_argument("--namespace", required=True, help="Namespace for the PGP key.")
    parser.add_argument("--pgp_key_path", required=True, help="Path to the file containing the PGP key.")
    args = parser.parse_args()

    add_pgp_key(args.token, args.private_registry_name, args.namespace, args.pgp_key_path)
