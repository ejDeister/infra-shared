resource "aws_cloudwatch_log_group" "shared_infra" {
  name              = "/shared-infra"
  retention_in_days = var.retention_days
}
