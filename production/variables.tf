# -----------------
# Project Variables
# -----------------
variable "aws_access_key" {
  description = "AWS access key stored in pass"
}

variable "aws_secret_key" {
  description  = "AWS secret key stored in pass"
}

variable "region" {
  description = "AWS region"
}

variable "domain_name" {
  description = "Domain name for the project"
}

variable "customer_name" {
  description = "The name of the client. Used for tagging and namespacing."
}

variable "environment" {
  description = "The programming environment - poc, dev, uat, prod, etc."
}


# Key Pair
variable "key_pair_name" {
  description = "Name of the SSH key pair"
}

variable "public_key_path" {
  description = "File lookup peformed on the specified SSH public key"
}


# Bastion
variable "bastion_ssh_port" {
  description = "Port assigned for bastion SSH communication"
  default     = "22"
}

variable "bastion_external_subnet_range" {
  description = "List of subnets and/or IPs that can access the bastion"
  type        = "list"
  default     = []
}

variable "bastion_zone_ttl" {
  description = "Bastion zone record set cache time to live (seconds)"
  default     = ""
}

variable "bastion_image_id" {
  description = "Bastion AMI image ID"
  default     = ""
}

variable "bastion_instance_type" {
  description = "Bastion instance type"
  default     = ""
}

variable "bastion_key_name" {
  description = "Bastion SSH key pair name"
  default     = ""
}

variable "bastion_security_groups" {
  description = "Bastion security group list"
  type        = "list"
  default     = []
}

variable "bastion_ebs_optimized" {
  description = "Bastion EBS optimized (true/false)"
  default     = "false"
}

variable "bastion_enable_monitoring" {
  description = "Bastion enable detailed monitoring (true/false)"
  default     = "false"
}

variable "bastion_volume_type" {
  description = "Bastion root volume type"
  default     = ""
}

variable "bastion_volume_size" {
  description = "Bastion root volume size (GB)"
  default     = ""
}

variable "bastion_max_size" {
  description = "Bastion ASG maximum size"
  default     = "1"
}

variable "bastion_min_size" {
  description = "Bastion ASG minimum size"
  default     = "1"
}

variable "bastion_desired_capacity" {
  description = "Bastion ASG desired size"
  default     = "1"
}


# VPC
variable "vpc_name" {
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  description = "The VPC CIDR block"
}

variable "vpc_private_subnets" {
  description = "List of VPC private subnet CIDRs"
  type        = "list"
  default     = []
}

variable "vpc_public_subnets" {
  description = "List of VPC public subnet CIDRs"
  type        = "list"
  default     = []
}

variable "vpc_enable_dns_hostnames" {
  description = "Enable private DNS hostnames in the VPC (true/false)"
  default     = false
}

variable "vpc_enable_dns_support" {
  description = "Enable private DNS support in the VPC (true/false)"
  default     = false
}

variable "vpc_create_database_subnet_group" {
  description = "Create database subnet group (true/false)"
  default     = false
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway (true/false)"
  default     = false
}

variable "vpc_enable_s3_endpoint" {
  description = "Enable S3 endpoint (true/false)"
  default     = false
}

variable "vpc_enable_dynamodb_endpoint" {
  description = "enable dynamodb endpoint (true/false)"
  default     = false
}


# Jenkins
variable "jenkins_web_port" {
  description = "Default port for Jenkins web services"
  default     = "8080"
}

variable "jenkins_jnlp_port" {
  description = "Default port for Jenkins JNLP slave agents"
  default     = "50000"
}

variable "jenkins_ext_web_port" {
  description = "Default external port for Jenkins web services"
  default     = "80"
}


# EFS
variable "efs_port" {
  description = "Default port for EFS"
  default     = "2049"
}


# Jenkins ELB
variable "jenkins_elb_cookie_expiration_period" {
  description = "The time period after which the Jenkins session cookie should be considered stale, expressed in seconds."
  default     = ""
}


# ECS
variable "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  default     = ""
}

variable "ecs_task_family" {
  description = "A unique name for your task definition"
  default     = ""
}

variable "ecs_task_network_mode" {
  description = "The Docker networking mode to use for the containers in the task. The valid values are none, bridge, and host"
  default     = ""
}

variable "ecs_task_volume_name" {
  description = "The name of the volume. This name is referenced in the sourceVolume parameter of container definition in the mountPoints section"
  default     = ""
}

variable "ecs_task_volume_host_path" {
  description = "The path on the host container instance that is presented to the container. If not set, ECS will create a nonpersistent data volume that starts empty and is deleted after the task has finished"
  default     = ""
}