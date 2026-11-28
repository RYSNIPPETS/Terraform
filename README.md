# Terraform AWS examples

This root configuration creates a VPC with two public and two private subnets across two Availability Zones, an internal TCP Network Load Balancer, a private S3 bucket, and an IAM policy scoped to listing that bucket. The IAM policy is available to attach to a role as needed. The load balancer uses an explicit security group scoped to the example VPC.

## Validate or plan

Use Terraform 1.17.2 or a newer 1.17 patch release. Initialization downloads the pinned modules and checks the AWS provider against the committed lock file.

```sh
terraform fmt -check -recursive
terraform init -backend=false -lockfile=readonly
terraform validate
```

To plan in AWS, use the AWS provider's normal credential chain and select a region with at least two available Availability Zones. For example, after signing in with an existing AWS CLI profile, run:

```sh
export AWS_PROFILE=my-sandbox
export AWS_REGION=us-east-1
terraform plan
```

If you apply the plan, AWS resources may incur charges. The load balancer uses TCP port 80. To serve traffic, run backends in the example VPC, allow traffic from the load balancer security group on TCP port 80, and set `nlb_target_ips` to the backends' private IPv4 addresses. The default target group starts empty so you can create the network first.

Use `terraform destroy` to remove an applied example. Empty the S3 bucket before destroying it.

## File catalog

The catalog is a static snapshot of the repositories' files. Open the corresponding repository on GitHub for its current file list. [index.html](index.html)
