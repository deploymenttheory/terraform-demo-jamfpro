# Terraform Jamf Pro Configuration Repository

This repository contains Terraform configurations for managing resources in Jamf Pro using the Jamf Pro Terraform provider. The workflows defined here automate the planning and application of Terraform configurations to your Jamf Pro environment, ensuring that your Jamf Pro settings are version-controlled and consistently applied.

## Prerequisites

- A Jamf Pro account with API access
- Terraform installed locally or in your CI/CD environment
- A GitHub account for storing this repository and using GitHub Actions

## Getting Started

1. **Fork or Clone Repository**: Start by forking or cloning this repository to your GitHub account.

2. **Configure Secrets**: Set up the following secrets in your GitHub repository settings:
    - `GITHUB_TOKEN`: A GitHub token with permissions to access this repository.
    - `TF_API_TOKEN`: Your Terraform Cloud API token for Terraform Cloud backend (if used).

3. **Update Terraform Variables**: Modify the `terraform` block in your `.tf` files to match your Jamf Pro instance details, including `instance_name`, `client_id`, and `client_secret`. For example:
    ```hcl
    provider "jamfpro" {
      instance_name   = var.jamfpro_instance_name
      client_id       = var.jamfpro_client_id
      client_secret   = var.jamfpro_client_secret
      log_level       = "debug"
    }
    ```
    Set the values for these variables in a `terraform.tfvars` file or through GitHub Actions environment variables.

4. **Define Your Resources**: Use Terraform resource definitions to manage your Jamf Pro resources, such as buildings, departments, policies, etc. An example for defining a building:
    ```hcl
    resource "jamfpro_building" "jamfpro_building_001" {
      name            = "Apple Park"
      street_address1 = "The McIntosh Tree"
      street_address2 = "One Apple Park Way"
      city            = "Cupertino"
      state_province  = "California"
      zip_postal_code = "95014"
      country         = "The United States of America"
    }
    ```

5. **Work with GitHub Actions**: This repository includes GitHub Actions workflows for automatically planning and applying Terraform configurations:
    - **Terraform Plan Workflow**: Triggered on push to non-main branches, this workflow generates and reviews a Terraform plan.
    - **Terraform Apply Workflow**: Triggered on push to the main branch, this workflow applies the Terraform plan, making the changes live in your Jamf Pro environment.

6. **Review and Merge Pull Requests**: Use pull requests to review and merge changes from feature branches into the main branch, triggering the Terraform Apply workflow.

7. **Versioning**: Upon successful application of Terraform configurations, a new tag is created and pushed, including a hash of the Terraform configurations for version tracking.

## Example Terraform Resource

Below is an example of defining a building in Jamf Pro using Terraform:

```hcl
resource "jamfpro_building" "example_building" {
  name            = "Example Building"
  street_address1 = "123 Example St"
  street_address2 = "Suite 100"
  city            = "Example City"
  state_province  = "Example State"
  zip_postal_code = "12345"
  country         = "Example Country"
}
```

## Security and Best Practices

Sensitive Data: Ensure sensitive data like client_secret is marked as sensitive in Terraform and securely stored in GitHub Secrets.
Review Changes: Always review Terraform plans before merging into the main branch to prevent unintended changes.
Access Control: Limit access to the GitHub repository and associated secrets to authorized personnel only.


## License
This project is licensed under the MIT License - see the LICENSE file for details.