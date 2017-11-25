# -------------
# Module Inputs
# -------------
variable "customer_name" {}
variable "environment" {}
variable "vpc_id" {}
variable "vpc_cidr_block" {}
variable "ssh_port" {}
variable "jenkins_web_port" {}
variable "jenkins_jnlp_port" {}

variable "external_subnet_range" {
  type    = "list"
  default = []
}