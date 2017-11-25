# -----------
# Jenkins ELB
# -----------
resource "aws_elb" "this" {
  subnets         = ["${var.elb_subnets}"]
  security_groups = ["${var.elb_security_groups}"]
  internal        = "${var.elb_internal}"

  listener {
    instance_port      = "${var.int_web_port}"
    instance_protocol  = "HTTP"
    lb_port            = "${var.ext_web_port}"
    lb_protocol        = "HTTP"
  }

  health_check {
    target              = "${var.elb_health_target}"
    interval            = "${var.elb_health_interval}"
    healthy_threshold   = "${var.elb_health_healthy_threshold}"
    unhealthy_threshold = "${var.elb_health_unhealthy_threshold}"
    timeout             = "${var.elb_health_timeout}"
  }

  tags {
    Name        = "${var.customer_name}_${var.environment}_elb"
    Environment = "${var.environment}"
    Terraform   = "true"
  }
}
