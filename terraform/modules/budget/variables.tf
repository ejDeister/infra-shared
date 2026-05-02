variable "limit_usd" {
  type    = number
  default = 20
}

variable "alert_email" {
  type = string
}

variable "target_role_arns" {
  type    = list(string)
  default = []
}

variable "target_user_names" {
  type    = list(string)
  default = []
}
