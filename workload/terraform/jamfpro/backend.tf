terraform { 
  cloud { 
    
    organization = "commonwealdharmffjkr" 

    workspaces { 
      name = "terraform-jamfpro-sandbox",
      tags = ["jamf_pro"]
    } 
  } 
}
