# -------------------------
# Project variable defaults
# -------------------------
customer_name = "brentwgtest"
environment   = "production"


# Key Pair
key_pair_name   = "brentwg_poc_key"
public_key_path = "/home/brentwg/.ssh/id_rsa.pub"


# VPC
vpc_name             = "brentwgtest-vpc"
vpc_cidr             = "10.10.0.0/16"
vpc_private_subnets  = ["10.10.1.0/24", "10.10.2.0/24"]
vpc_public_subnets   = ["10.10.11.0/24", "10.10.12.0/24"]
vpc_database_subnets = ["10.10.21.0/24", "10.10.22.0/24"]

vpc_enable_dns_hostnames = true
vpc_enable_dns_support   = true

vpc_create_database_subnet_group = false
vpc_enable_nat_gateway           = true
vpc_enable_s3_endpoint           = true
vpc_enable_dynamodb_endpoint     = false


# Bastion
bastion_ssh_port              = "22"
bastion_external_subnet_range = [
  "24.86.86.43/32",
  "206.191.105.220/32"
]

bastion_zone_ttl = "300"

bastion_image_id          = "ami-32d8124a"
bastion_instance_type     = "t2.micro"
bastion_ebs_optimized     = "false"
bastion_enable_monitoring = "false"
bastion_volume_type       = "gp2"
bastion_volume_size       = "8"

bastion_max_size         = "1"
bastion_min_size         = "1"
bastion_desired_capacity = "1"
