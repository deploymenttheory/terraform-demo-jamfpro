# Terraform Jamf Pro Configuration Repository

This repository contains Terraform configurations for managing resources in Jamf Pro across multiple environments using the Jamf Pro Terraform provider. The workflows defined here automate the planning and application of Terraform configurations to your Jamf Pro environments, ensuring that your Jamf Pro settings are version-controlled and consistently applied.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Repository Structure](#repository-structure)
- [Environment Setup](#environment-setup)
- [Workflow Overview](#workflow-overview)
- [Branching Strategy](#branching-strategy)
- [Getting Started](#getting-started)
- [GitHub Actions Workflows](#github-actions-workflows)
- [Drift Detection and Correction](#drift-detection-and-correction)
- [Example Terraform Resource](#example-terraform-resource)
- [Security and Best Practices](#security-and-best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

- **Jamf Pro Client Credentials**: A Jamf Pro client id and secret with appropriate API access is required. [client credentials](https://developer.jamf.com/jamf-pro/docs/client-credentials).
- **Terraform**: Terraform must be installed locally or available in your CI/CD environment. [Download Terraform](https://www.terraform.io/downloads.html).
- **Terraform Cloud**: An account on Terraform Cloud for managing Terraform state and running Terraform in a consistent environment. [Sign up for Terraform Cloud](https://app.terraform.io/signup/account).
- **GitHub Account**: A GitHub account for storing this repository and using GitHub Actions for automation. [Sign up for GitHub](https://github.com/join).

## Repository Structure

```
.
├── .github
│   └── workflows
│       ├── promote-to-sandbox.yml
│       ├── promote-to-staging.yml
│       ├── promote-to-production.yml
│       └── drift-detection-correction.yml
├── workload
│   └── terraform
│       └── jamfpro
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
├── README.md
└── .gitignore
```

## Environment Setup

This project supports three environments:

1. Sandbox
2. Staging
3. Production

Each environment has its own Terraform Cloud workspace:

- `terraform-jamfpro-sandbox`
- `terraform-jamfpro-staging`
- `terraform-jamfpro-production`

## Workflow Overview

1. Developers create feature branches prefixed with `feature-`, `bugfix-`, or `release-`.
2. Changes are first promoted to the Sandbox environment.
3. After testing in Sandbox, changes can be promoted to Staging via a pull request.
4. Finally, changes are promoted to Production via another pull request.

## Branching Strategy

- `feature-*`: For new features
- `bugfix-*`: For bug fixes
- `release-*`: For release preparation

## Getting Started

1. **Fork or Clone Repository**: Start by forking or cloning this repository to your GitHub account.

2. **Configure Github Secrets**: Set up the following secrets in your GitHub repository settings:
    - `TF_API_TOKEN`: Your Terraform Cloud API token for Terraform Cloud backend.

3. **Configure Terraform Cloud Secrets**: Set up the following secrets in your Terraform Cloud workspace variable settings for each environment (Sandbox, Staging, Production):
    - `JAMFPRO_INSTANCE_FQDN`: Your Jamf Pro instance URL. For example: `https://your-instance.jamfcloud.com`.
    - `JAMFPRO_AUTH_METHOD`: Can be either `basic` or `oauth2`.
    - `JAMFPRO_CLIENT_ID`: Your Jamf Pro client id when `JAMFPRO_AUTH_METHOD` is set to 'oauth2'.
    - `JAMFPRO_CLIENT_SECRET`: Your Jamf Pro client secret when `JAMFPRO_AUTH_METHOD` is set to 'oauth2'.
    - `JAMFPRO_BASIC_AUTH_USERNAME`: Your Jamf Pro username when `JAMFPRO_AUTH_METHOD` is set to 'basic'.
    - `JAMFPRO_BASIC_AUTH_PASSWORD`: Your Jamf Pro user password when `JAMFPRO_AUTH_METHOD` is set to 'basic'.

   Note: For Terraform Cloud, when setting variables you do not need to prefix your env vars with `TF_VAR_` as Terraform Cloud automatically does this for you. Additionally, ensure to select the variable category as `Terraform variable`, with the HCL tickbox unchecked.

4. **Update Terraform Variables**: Modify the `terraform` block in your `.tf` files to match your Jamf Pro instance details. For example:

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

   It's strongly recommended for beginners to ensure that `jamfpro_load_balancer_lock` is set to true, to avoid any issues with the Jamf Pro load balancer.

5. **Backend Configuration**: For our multi-environment setup, we'll be using Terraform workspaces. This approach allows us to use a single set of configuration files while maintaining separate states for each environment. Here's how to structure it:

   In your main Terraform configuration file (e.g., `main.tf`):

   ```hcl
   terraform {
     cloud {
       organization = "deploymenttheory"
       workspaces {
         tags = ["jamfpro"]
       }
     }
   }
   ```

   This configuration tells Terraform to use Terraform Cloud with the "deploymenttheory" organization and to work with any workspace tagged with "jamfpro".

   In Terraform Cloud:
   1. Create three workspaces:
      - `terraform-jamfpro-sandbox`
      - `terraform-jamfpro-staging`
      - `terraform-jamfpro-production`
   2. Tag each of these workspaces with the "jamfpro" tag.
   3. Set workspace-specific variables in Terraform Cloud for each environment. For example, you might have a variable `environment` set to "sandbox", "staging", or "production" in the respective workspaces.

   In your Terraform configuration, you can then use these workspace-specific variables to customize resources for each environment. For example:

   ```hcl
   resource "jamfpro_building" "example" {
     name = "Building-${var.environment}"
     // other attributes...
   }
   ```

   This approach ensures that each environment has its own isolated state in Terraform Cloud while allowing you to use a single set of configuration files. It provides flexibility in managing environment-specific configurations through Terraform Cloud workspace variables.

   Remember to set up appropriate access controls and variable values for each workspace in Terraform Cloud to maintain proper separation between environments.

6. **Terraform Provider Configuration**: Specify the provider source and version:

   ```hcl
   terraform {
     required_providers {
       jamfpro = {
         source  = "deploymenttheory/jamfpro"
         version = "0.1.11"
       }
     }
   }
   ```

7. **Define Your Resources**: Use Terraform resource definitions to manage your Jamf Pro resources.

8. **Create a New Branch**: Create a new branch with the appropriate prefix (`feature-`, `bugfix-`, or `release-`).

9. **Make Changes and Push**: Make your changes and push to GitHub.

10. **Promote to Sandbox**: The "Promote to Sandbox" workflow will automatically run.

11. **Promote to Staging**: After testing in Sandbox, create a pull request to merge into the `staging` branch.

12. **Promote to Production**: Once approved and merged to staging, create another pull request to merge `staging` into `production`.

## GitHub Actions Workflows

1. **Promote to Sandbox** (`promote-to-sandbox.yml`)
   - Triggered on push to branches prefixed with `feature-`, `bugfix-`, or `release-`
   - Applies changes to the Sandbox environment

2. **Promote to Staging** (`promote-to-staging.yml`)
   - Triggered on pull request to the `staging` branch
   - Plans changes for the Staging environment
   - Applies changes when the PR is merged

3. **Promote to Production** (`promote-to-production.yml`)
   - Triggered on pull request to the `production` branch
   - Plans changes for the Production environment
   - Applies changes when the PR is merged

## Drift Detection and Correction

The `drift-detection-correction.yml` workflow runs nightly to detect and correct any drift in your environments:

- Checks for drift in Sandbox, Staging, and Production environments
- Automatically corrects drift if detected
- Sends notifications (configure as needed)

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

- Use Terraform Cloud for secure state management
- Implement branch protection rules for `staging` and `production` branches
- Review all plans before applying changes
- Use least-privilege principle for API credentials
- Ensure sensitive data like `client_secret` is marked as sensitive in Terraform and securely stored in GitHub Secrets
- Always review Terraform plans before merging into the main branch to prevent unintended changes
- Limit access to the GitHub repository and associated secrets to authorized personnel only

## Troubleshooting

- Check GitHub Actions logs for detailed error messages
- Verify Terraform Cloud workspace configurations
- Ensure Jamf Pro API credentials are correct and have necessary permissions

## Contributing

1. Fork the repository
2. Create a new branch with the appropriate prefix
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.