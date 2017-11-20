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
