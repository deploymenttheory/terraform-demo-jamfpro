resource "jamfpro_policy" "jamfpro_policy_script_001" {
  name                          = "tf-demo-policy-script-correct-application-permissions"
  enabled                       = true
  trigger_checkin               = false
  trigger_enrollment_complete   = false
  trigger_login                 = false
  trigger_network_state_changed = false
  trigger_startup               = false
  trigger_other                 = "EVENT" // "USER_INITIATED" for self service trigger , "EVENT" for an event trigger
  frequency                     = "Once per computer"
  retry_event                   = "none"
  retry_attempts                = -1
  notify_on_each_failed_retry   = false
  target_drive                  = "/"
  offline                       = false
  category_id                   = -1
  site_id                       = -1

  network_limitations {
    minimum_network_connection = "No Minimum"
    any_ip_address             = false
  }

  scope {
    all_computers = false
    all_jss_users = false
  }

  self_service {
    use_for_self_service            = true
    self_service_display_name       = ""
    install_button_text             = "Install"
    reinstall_button_text           = "Reinstall"
    self_service_description        = ""
    force_users_to_view_description = false

    feature_on_main_page = false
  }



  payloads {
    scripts {
      id          = jamfpro_script.jamfpro_script_001.id
      priority    = "After"
      parameter4  = ""
      parameter5  = ""
      parameter6  = ""
      parameter7  = ""
      parameter8  = ""
      parameter9  = ""
      parameter10 = ""
      parameter11 = ""

    }

    user_interaction {
      message_start            = "Policy is about to run."
      allow_user_to_defer      = true
      allow_deferral_until_utc = "2024-12-31T23:59:59Z"
      allow_deferral_minutes   = 1440
      message_finish           = "Policy has completed."
    }

    # user_interaction {
    #   message_start            = "Policy is about to run."
    #   allow_users_to_defer     = true
    #   allow_deferral_until_utc = "2024-12-31T23:59:59Z"
    #   allow_deferral_minutes   = 1440
    #   message_finish           = "Policy has completed."
    # }
  }
}

# resource "jamfpro_policy" "jamfpro_policy_script_002" {
#   name                          = "tf-demo-policy-script-reset_safari"
#   enabled                       = false
#   trigger_checkin               = false
#   trigger_enrollment_complete   = false
#   trigger_login                 = false
#   trigger_network_state_changed = false
#   trigger_startup               = false
#   trigger_other                 = "EVENT" // "USER_INITIATED" for self service trigger , "EVENT" for an event trigger
#   frequency                     = "Once per computer"
#   retry_event                   = "none"
#   retry_attempts                = -1
#   notify_on_each_failed_retry   = false
#   target_drive                  = "/"
#   offline                       = false
#   category_id                   = -1
#   site_id                       = -1

#   network_limitations {
#     minimum_network_connection = "No Minimum"
#     any_ip_address             = false
#   }

#   scope {
#     all_computers = false
#     all_jss_users = false
#   }

#   self_service {
#     use_for_self_service            = true
#     self_service_display_name       = ""
#     install_button_text             = "Install"
#     self_service_description        = ""
#     force_users_to_view_description = false

#     feature_on_main_page = false
#   }

#   payloads {
#     scripts {
#       id          = jamfpro_script.jamfpro_script_003.id
#       priority    = "After"
#       parameter4  = ""
#       parameter5  = ""
#       parameter6  = ""
#       parameter7  = ""
#       parameter8  = ""
#       parameter9  = ""
#       parameter10 = ""
#       parameter11 = ""

#     }
#   }
# }





