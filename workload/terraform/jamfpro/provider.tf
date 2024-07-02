terraform {
  required_providers {
    jamfpro = {
      source  = "deploymenttheory/jamfpro"
      version = "0.1.0"
    }
  }
}

provider "jamfpro" {
  jamf_instance_fqdn = var.jamfpro_instance_fqdn
  auth_method        = var.jamfpro_auth_method
  client_id          = var.jamfpro_client_id
  client_secret      = var.jamfpro_client_secret
  # basic_auth_username           = var.basic_auth_username
  # basic_auth_password           = var.basic_auth_password
  log_level                            = var.jamfpro_log_level
  log_output_format                    = var.jamfpro_log_output_format
  log_console_separator                = var.jamfpro_log_console_separator
  log_export_path                      = var.jamfpro_log_export_path
  export_logs                          = var.jamfpro_export_logs
  hide_sensitive_data                  = var.jamfpro_hide_sensitive_data
  jamf_load_balancer_lock              = var.jamfpro_jamf_load_balancer_lock
  token_refresh_buffer_period_seconds  = var.jamfpro_token_refresh_buffer_period_seconds
  mandatory_request_delay_milliseconds = var.jamfpro_mandatory_request_delay_milliseconds
}

variable "jamfpro_instance_fqdn" {
  description = "The Jamf Pro FQDN (fully qualified domain name). Example: https://mycompany.jamfcloud.com"
  default     = ""
}

variable "jamfpro_auth_method" {
  description = "Auth method chosen for Jamf. Options are 'basic' or 'oauth2'."
  sensitive   = true
  default     = "oauth2"
}

variable "jamfpro_client_id" {
  description = "The Jamf Pro Client ID for authentication."
  sensitive   = true
  default     = ""
}

variable "jamfpro_client_secret" {
  description = "The Jamf Pro Client Secret for authentication."
  sensitive   = true
  default     = ""
}

variable "jamfpro_basic_auth_username" {
  description = "The Jamf Pro username used for authentication."
  default     = ""
}

variable "jamfpro_basic_auth_password" {
  description = "The Jamf Pro password used for authentication."
  sensitive   = true
  default     = ""
}

variable "jamfpro_log_level" {
  description = "The logging level: debug, info, warning, or none."
  default     = "debug"
}

variable "jamfpro_log_output_format" {
  description = "The output format of the logs. Use 'JSON' for JSON format, 'console' for human-readable format."
  default     = "pretty"
}

variable "jamfpro_log_console_separator" {
  description = "The separator character used in console log output."
  default     = " "
}

variable "jamfpro_log_export_path" {
  description = "Specify the path to export http client logs to."
  default     = ""
}

variable "jamfpro_export_logs" {
  description = "Export logs to file."
  default     = false
}

variable "jamfpro_hide_sensitive_data" {
  description = "Define whether sensitive fields should be hidden in logs."
  default     = true
}

variable "jamfpro_custom_cookies" {
  description = "Custom cookies for the HTTP client."
  type = list(object({
    name  = string
    value = string
  }))
  default = []
}

variable "jamfpro_jamf_load_balancer_lock" {
  description = "Programmatically determines all available web app members in the load balancer and locks all instances of httpclient to the app for faster executions."
  default     = true
}

variable "jamfpro_token_refresh_buffer_period_seconds" {
  description = "The buffer period in seconds for token refresh."
  default     = 300
}

variable "jamfpro_mandatory_request_delay_milliseconds" {
  description = "A mandatory delay after each request before returning to reduce high volume of requests in a short time."
  default     = 150
}
