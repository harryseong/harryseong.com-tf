locals {
  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}

module "s3_bucket_angular_test" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  create_bucket = true
  bucket        = "test.harryseong.com"

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  website = {
    index_document = "index.html"
    error_document = "index.html"
    routing_rules  = null
  }

  tags = local.tags
}

resource "aws_s3_bucket_policy" "s3_bucket_policy_angular_test" {
  bucket = module.s3_bucket_angular_test.s3_bucket_id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "s3-bucket-policy-test.harryseong.com"
    Statement = [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::test.harryseong.com/*"
      }
    ]
  })
}
