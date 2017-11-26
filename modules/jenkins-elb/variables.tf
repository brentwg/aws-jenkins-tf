# -------------
# Module Inputs
# -------------
variable "customer_name" {
  description = "The name of the client. Used for tagging and namespacing."
}

variable "environment" {
  description = "The programming environment - poc, dev, uat, prod, etc."
}

variable "elb_subnets" {
  description = ""
  type        = "list"
  default     = []
}

variable "elb_security_groups" {
  description = ""
  type        = "list"
  default     = []
}

variable "elb_internal" {
  description = "State whether the ELB is internal or public facing"
  default     = "false"
}

variable "int_web_port" {
  description = "ELB port assigned for internal WEB communication"
  default     = ""
}

variable "ext_web_port" {
  description = "ELB port assigned for external WEB communication"
  default     = ""
}

variable "elb_health_target" {
  description = ""
  default     = "HTTP:80/"
}

variable "elb_health_interval" {
  description = ""
  default     = "30"
}

variable "elb_health_healthy_threshold" {
  description = ""
  default     = "2"
}

variable "elb_health_unhealthy_threshold" {
  description = ""
  default     = "2"
}

variable "elb_health_timeout" {
  description = ""
  default     = "5"
}

variable "elb_cookie_expiration_period" {
  description = ""
  default     = ""
}