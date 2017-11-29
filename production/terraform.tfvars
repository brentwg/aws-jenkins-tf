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


# Jenkins
jenkins_web_port     = "8080"
jenkins_jnlp_port    = "50000"
jenkins_ext_web_port = "80"


# EFS
efs_port = "2049"


# Jenkins ELB
jenkins_elb_cookie_expiration_period = "3600"


# ECS
ecs_cluster_name = "jenkins-cluster"

# ECS - task
ecs_task_family           = "jenkins-master"
ecs_task_network_mode     = "bridge"
ecs_task_volume_name      = "data-volume"
ecs_task_volume_host_path = "/data/"
ecs_task_image            = "jenkins/jenkins:lts"
ecs_task_container_path   = "/var/jenkins_home"

# ECS - template for user_data
ecs_user_data_efs_mountpoint = "/data"
ecs_user_data_efs_owner      = "1000"

# ECS - launch configuration
ecs_lc_image_id      = "ami-7114c909"
ecs_lc_instance_type = "t2.micro"

ecs_lc_data_block_device_name = "/dev/xvdz"
ecs_lc_data_block_device_type = "gp2"
ecs_lc_data_block_device_size = "24"

ecs_lc_root_device_type = "gp2"
ecs_lc_root_device_size = "12"

# ECS - auto scaling group
ecs_asg_health_check_type         = "EC2"
ecs_asg_min_size                  = "2"
ecs_asg_max_size                  = "5"
ecs_asg_desired_capacity          = "2"
ecs_asg_wait_for_capacity_timeout = "0"
