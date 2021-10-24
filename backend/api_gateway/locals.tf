locals {
  tags = {
    Terraform   = "true"
    Environment = "api"
  }

  api_prefix = "api"
  api_url    = format("%s.%s", local.api_prefix, var.domain_name)
}
