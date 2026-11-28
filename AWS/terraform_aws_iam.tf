module "iam" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.11.3"

  name_prefix = "terraform-example-list-bucket-"
  description = "List objects in the example S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "s3:ListBucket"
      Resource = module.s3-bucket.s3_bucket_arn
    }]
  })
}
