# ------------
# AWS Provider
# ------------
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}


# --------
# Key Pair
# --------
module "key_pair" {
  source = "git::https://github.com/brentwg/terraform-aws-key-pair.git?ref=1.0"

  key_pair_name   = "${var.key_pair_name}"
  public_key_path = "${var.public_key_path}"
}


# --------------------------------
# Lookup Region Availability Zones
# --------------------------------
data "aws_availability_zones" "available" {}


# ------------------------------
# Lookup Domain Zone Information
# ------------------------------
data "aws_route53_zone" "my_domain" {
  name = "${var.domain_name}"
}


# ---
# VPC
# ---
module "vpc" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git?ref=v1.3.0"

  name                = "${var.vpc_name}"
  cidr                = "${var.vpc_cidr}"
  azs                 = "${data.aws_availability_zones.available.names}"
  private_subnets     = "${var.vpc_private_subnets}"
  public_subnets      = "${var.vpc_public_subnets}"

  enable_dns_hostnames = "${var.vpc_enable_dns_hostnames}"
  enable_dns_support   = "${var.vpc_enable_dns_support}"

  create_database_subnet_group = "${var.vpc_create_database_subnet_group}"
  enable_nat_gateway           = "${var.vpc_enable_nat_gateway}"
  enable_s3_endpoint           = "${var.vpc_enable_s3_endpoint}"
  enable_dynamodb_endpoint     = "${var.vpc_enable_dynamodb_endpoint}"

  tags = {
    Name        = "${var.vpc_name}"
    Environment = "${var.environment}"
    Terraform   = "true"
  }

  private_subnet_tags = {
    SubnetType = "private"
  }

  public_subnet_tags = {
    SubnetType = "public"
  }
}


# ----------------------
# Bastion Security Group
# ----------------------
module "bastion_security_group" {
  source = "../modules/bastion-security-group"

  customer_name         = "${var.customer_name}"
  environment           = "${var.environment}"
  vpc_id                = "${module.vpc.vpc_id}"
  vpc_cidr_block        = "${module.vpc.vpc_cidr_block}"
  ssh_port              = "${var.bastion_ssh_port}"
  external_subnet_range = "${var.bastion_external_subnet_range}"
}


# -------
# Bastion
# -------
module "bastion" {
  source = "git::https://github.com/brentwg/terraform-aws-bastion.git?ref=1.0"

  customer_name       = "${var.customer_name}"
  environment         = "${var.environment}"

  # Route53
  bastion_zone_id     = "${data.aws_route53_zone.my_domain.zone_id}"
  bastion_domain_name = "bastion.${var.domain_name}"
  bastion_zone_ttl    = "${var.bastion_zone_ttl}"

  # Launch config
  bastion_region        = "${var.region}"      
  bastion_image_id      = "${var.bastion_image_id}"
  bastion_instance_type = "${var.bastion_instance_type}"
  bastion_key_name      = "${var.key_pair_name}"

  bastion_security_groups   = [
    "${module.bastion_security_group.bastion_security_group_id}"
  ]
  
  bastion_ebs_optimized     = "${var.bastion_ebs_optimized}"
  bastion_enable_monitoring = "${var.bastion_enable_monitoring}"
  bastion_volume_type       = "${var.bastion_volume_type}"
  bastion_volume_size       = "${var.bastion_volume_size}"

  # ASG
  bastion_max_size         = "${var.bastion_max_size}"
  bastion_min_size         = "${var.bastion_min_size}"
  bastion_desired_capacity = "${var.bastion_desired_capacity}"

  bastion_asg_subnets      = ["${module.vpc.public_subnets}"]
}


# ----------------------
# IAM - ECS Service Role
# ----------------------
module "ecs_service_role" {
  source = "../modules/ecs-service-role"

  customer_name            = "${var.customer_name}"
  environment              = "${var.environment}"
}


# --------------------------
# IAM - EC2 Instance Profile
# --------------------------
module "ec2_instance_profile" {
  source = "../modules/ec2-instance-profile"

  customer_name            = "${var.customer_name}"
  environment              = "${var.environment}"
}


# ----------------------
# Jenkins Security Group
# ----------------------
module "jenkins_security_group" {
  source = "../modules/jenkins-security-group"

  customer_name         = "${var.customer_name}"
  environment           = "${var.environment}"
  vpc_id                = "${module.vpc.vpc_id}"
  vpc_cidr_block        = "${module.vpc.vpc_cidr_block}"
  ssh_port              = "${var.bastion_ssh_port}"
  jenkins_web_port      = "${var.jenkins_web_port}"
  jenkins_jnlp_port     = "${var.jenkins_jnlp_port}"
  external_subnet_range = "${var.bastion_external_subnet_range}"
}
