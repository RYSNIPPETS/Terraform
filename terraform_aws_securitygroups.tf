module "security-group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "6.0.0"

  name        = "terraform-example-nlb"
  description = "Allow TCP traffic between the NLB and clients and targets in the example VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = {
    vpc_clients = {
      ip_protocol = "tcp"
      from_port   = local.nlb_port
      to_port     = local.nlb_port
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }

  egress_rules = {
    vpc_targets = {
      ip_protocol = "tcp"
      from_port   = local.nlb_port
      to_port     = local.nlb_port
      cidr_ipv4   = module.vpc.vpc_cidr_block
    }
  }
}
