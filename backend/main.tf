module "api_gateway" {
  source                      = "./api_gateway"
  env                         = "api"
  project_name                = var.project_name
  domain_name                 = var.domain_name
  public_hosted_zone_id       = var.public_hosted_zone_id
  lambda_functions            = module.lambda.functions
  cognito_user_pool_client_id = module.cognito.cognito_user_pool_client_id
  cognito_user_pool_endpoint  = module.cognito.cognito_user_pool_endpoint
}

module "lambda" {
  source                        = "./lambda"
  env                           = "api"
  project_name                  = var.project_name
  domain_name                   = var.domain_name
  vpc_default_security_group_id = var.vpc_default_security_group_id
  vpc_private_subnet_ids        = var.vpc_private_subnet_ids
}

module "dynamodb" {
  source       = "./dynamodb"
  env          = "shared"
  project_name = var.project_name
}

module "cognito" {
  source                = "./cognito"
  env                   = "shared"
  project_name          = var.project_name
  domain_name           = var.domain_name
  public_hosted_zone_id = var.public_hosted_zone_id
}

module "ecr" {
  source       = "./ecr"
  env          = "shared"
  project_name = var.project_name
  domain_name  = var.domain_name
}

# Event bridge CRON trigger to publish daily to SNS topic.
# module "event_bridge" {
#   source       = "./event_bridge"
#   env          = "shared"
#   project_name = var.project_name
#   domain_name  = var.domain_name
# }

# SNS topic to send SMS weather updates.
# module "sns" {
#   source       = "./sns"
#   env          = "shared"
#   project_name = var.project_name
#   domain_name  = var.domain_name
# }
