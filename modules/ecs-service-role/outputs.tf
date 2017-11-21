# --------------
# Module Outputs
# --------------
output "ecs_service_role_arn" {
  value = "${aws_iam_role.ecs_service_role.arn}"
}
