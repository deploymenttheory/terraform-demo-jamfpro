# Terraform Jamf Pro Configuration Repository

This repository contains Terraform configurations for managing resources in Jamf Pro using the Jamf Pro Terraform provider. The workflows defined here automate the planning and application of Terraform configurations to your Jamf Pro environment, ensuring that your Jamf Pro settings are version-controlled and consistently applied.

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

- **Jamf Pro Client Credentials**: A Jamf Pro client id and secret with appropriate API access is required. [client credentials](https://developer.jamf.com/jamf-pro/docs/client-credentials).
- **Terraform**: Terraform must be installed locally or available in your CI/CD environment. [Download Terraform](https://www.terraform.io/downloads.html).
- **Terraform Cloud**: An account on Terraform Cloud for managing Terraform state and running Terraform in a consistent environment. [Sign up for Terraform Cloud](https://app.terraform.io/signup/account).
- **GitHub Account**: A GitHub account for storing this repository and using GitHub Actions for automation. [Sign up for GitHub](https://github.com/join).


## Getting Started

1. **Fork or Clone Repository**: Start by forking or cloning this repository to your GitHub account.

2. **Configure Github Secrets**: Set up the following secrets in your GitHub repository settings:
    - `TF_API_TOKEN`: Your Terraform Cloud API token for Terraform Cloud backend (if used).

3. **Configure Terraform Cloud Secrets**: Set up the following secrets in your terraform cloud workspace variable settings:
    - `JAMFPRO_INSTANCE_FQDN`: Your Jamf Pro instance secret. For example: insert `https://your-instance.jamfcloud.com`, as the value.
    - `JAMFPRO_AUTH_METHOD`: can be either basic or oauth2. For example: insert `oauth2`, as the value.
    - `JAMFPRO_CLIENT_ID`: Your Jamf Pro client id when `JAMFPRO_AUTH_METHOD` is set to 'oauth2'.
    - `JAMFPRO_CLIENT_SECRET`: Your Jamf Pro client secret when `JAMFPRO_AUTH_METHOD` is set to 'oauth2'.
    - `JAMFPRO_BASIC_AUTH_USERNAME`: Your Jamf Pro username when `JAMFPRO_AUTH_METHOD` is set to 'basic'.
    - `JAMFPRO_BASIC_AUTH_PASSWORD`: Your Jamf Pro user password when `JAMFPRO_AUTH_METHOD` is set to 'basic'.

4. **Update Terraform Variables**: Modify the `terraform` block in your `.tf` files to match your Jamf Pro instance details, including `jamfpro_instance_fqdn"`, `auth_method`, and either; `client_id` + `client_secret` or `jamfpro_basic_auth_username` + `jamfpro_basic_auth_password`. For example:

```hcl
    provider "jamfpro" {
    jamfpro_instance_fqdn                = var.jamfpro_instance_fqdn
    jamfpro_load_balancer_lock           = var.jamfpro_jamf_load_balancer_lock
    auth_method                          = var.jamfpro_auth_method
    client_id                            = var.jamfpro_client_id
    client_secret                        = var.jamfpro_client_secret
    log_level                            = var.jamfpro_log_level
    log_output_format                    = var.jamfpro_log_output_format
    log_console_separator                = var.jamfpro_log_console_separator
    log_export_path                      = var.jamfpro_log_export_path
    export_logs                          = var.jamfpro_export_logs
    hide_sensitive_data                  = var.jamfpro_hide_sensitive_data
    token_refresh_buffer_period_seconds  = var.jamfpro_token_refresh_buffer_period_seconds
    mandatory_request_delay_milliseconds = var.jamfpro_mandatory_request_delay_milliseconds
    }
```

Set the values for these variables in a `terraform.tfvars` file, through GitHub Actions environment variables or through TFcloud workspace variables.

It's strongly recconmended for beginners to ensure that `jamfpro_load_balancer_lock` is set to true, to avoid any issues with the Jamf Pro load balancer.

Review the supplied provider.tf file for more information on the provider configuration.


5. **Backend Configuration**:This project uses Terraform Cloud as the backend for state management and execution. Configure the Terraform Cloud backend by specifying your organization and workspace in your Terraform configuration:

```hcl
terraform {
  cloud {
    organization = "your-terraform-cloud-organization"

    workspaces {
      name = "your-terraform-cloud-workspace"
    }
  }
}
```

6. **Terraform Provider Configuration**
The project uses the jamfpro Terraform provider to interact with your Jamf Pro environment. Specify the provider source and version in your Terraform configuration:

```hcl
Copy code
terraform {
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "0.1.2"
    }
  }
}
```
Ensure that the provider version is compatible with your Jamf Pro environment.



Replace your-terraform-cloud-organization and your-terraform-cloud-workspace with your actual Terraform Cloud organization and workspace names.

7. **Define Your Resources**: Use Terraform resource definitions to manage your Jamf Pro resources, such as buildings, departments, policies, etc. An example for defining a building:
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