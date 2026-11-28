module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.18.0"

  bucket_prefix = "rysnippets-terraform-example-"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
