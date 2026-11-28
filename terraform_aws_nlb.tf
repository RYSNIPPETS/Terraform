module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "10.5.1"

  name_prefix                = "tfex-"
  load_balancer_type         = "network"
  internal                   = true
  vpc_id                     = module.vpc.vpc_id
  subnets                    = module.vpc.private_subnets
  enable_deletion_protection = false

  create_security_group = false
  security_groups       = [module.security-group.id]

  listeners = {
    tcp = {
      port     = local.nlb_port
      protocol = "TCP"
      forward  = { target_group_key = "app" }
    }
  }

  target_groups = {
    app = {
      name_prefix       = "tfex-"
      protocol          = "TCP"
      port              = local.nlb_port
      target_type       = "ip"
      create_attachment = false
    }
  }

  additional_target_group_attachments = {
    for ip in var.nlb_target_ips : ip => {
      target_group_key = "app"
      target_id        = ip
    }
  }
}

locals {
  nlb_port = 80
}

variable "nlb_target_ips" {
  description = "Private IPv4 addresses of backends listening on TCP port 80 in the example VPC."
  type        = set(string)
  default     = []
}

output "nlb_dns_name" {
  description = "DNS name of the internal Network Load Balancer."
  value       = module.nlb.dns_name
}
