# ----------------
# ECS Service Role
# ----------------
resource "aws_iam_role" "ecs_service_role" {
  name = "${var.customer_name}_${var.environment}_ecs_service_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ecs.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# -----------------------
# ECS Service Role Policy
# -----------------------
resource "aws_iam_role_policy" "ecs_service_policy" {
  name = "${var.customer_name}_${var.environment}_s3_access_policy"
  role = "${aws_iam_role.ecs_service_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Action": [
            "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
            "elasticloadbalancing:DeregisterTargets",
            "elasticloadbalancing:Describe*",
            "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
            "elasticloadbalancing:RegisterTargets",
            "ec2:Describe*",
            "ec2:AuthorizeSecurityGroupIngress"
          ],      
          "Resource": "*"
      }
  ]
}
EOF
}
