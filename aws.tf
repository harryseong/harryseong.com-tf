provider "aws" {
  region = local.region

  default_tags {
    tags = {
      Automation    = "Terraform"
      AutomationKey = "harryseong.com-tf-main"
    }
  }
}

locals {
  region = "us-east-1"
}
