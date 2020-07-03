module "security-group" {
  count   = var.security-group-create ? var.security-group-count : 0
  source  = "terraform-aws-modules/security-group/aws"
  version = "3.11.0"
  # insert the 2 required variables here
  sg_name   = var.security_group_name
  vpc_id = var.vpc_id
}

module "aws_es" {
  count  = var.aws-es-create ? var.aws-es-count : 0
  source = "lgallard/elasticsearch/aws"

  domain_name           = var.es_domain_name
  elasticsearch_version = var.es_version

  cluster_config = {
    dedicated_master_enabled = "true"
    instance_count           = var.instance_count
    instance_type            = var.instance_type
    zone_awareness_enabled   = "true"
    availability_zone_count  = "3"
  }

  ebs_options = {
    ebs_enabled = "true"
    volume_size = "25"
  }

  encrypt_at_rest = {
    enabled    = "true"
    kms_key_id = "alias/aws/es"
  }

  vpc_options_subnet_ids         = var.subnet_ids
  vpc_options_security_group_ids = var.security_group_name
  
  node_to_node_encryption_enabled                = true
  snapshot_options_automated_snapshot_start_hour = 23

  access_policies = templatefile("${path.module}/access_policies.tpl", {
    region      = data.aws_region.current.name,
    account     = data.aws_caller_identity.current.account_id,
    domain_name = var.es_domain_name
  })

  timeouts_update = "60m"

  tags = {
    Owner = "yash-devops"
    env   = "yash"
  }

}
