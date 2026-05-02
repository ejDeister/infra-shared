variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "domain_name" {
  type = string
}

variable "existing_zone_id" {
  type = string
}

variable "state_bucket_name" {
  type = string
}

variable "retention_days" {
  type    = number
  default = 7
}

variable "budget_limit_usd" {
  type    = number
  default = 20
}

variable "alert_email" {
  type = string
}

variable "budget_target_role_arns" {
  type    = list(string)
  default = []
}

variable "budget_target_user_names" {
  type    = list(string)
  default = []
}

variable "github_repo" {
  type        = string
  description = "GitHub repo in owner/name format, used for OIDC trust policy"
}
