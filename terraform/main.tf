terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "state_backend" {
  source      = "./modules/state-backend"
  bucket_name = var.state_bucket_name
}

module "dns" {
  source      = "./modules/dns"
  domain_name = var.domain_name
}

module "acm" {
  source  = "./modules/acm"
  zone_id = module.dns.zone_id
  domain  = var.domain_name
}

module "oidc" {
  source = "./modules/oidc"
}

module "cloudwatch" {
  source         = "./modules/cloudwatch"
  retention_days = var.retention_days
}

resource "aws_iam_role" "shared_infra_deploy" {
  name = "shared-infra-deploy"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Federated = module.oidc.oidc_provider_arn }
      Action    = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringLike = {
          "token.actions.githubusercontent.com:sub" = "repo:ejDeister/infra-shared:*"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "shared_infra_deploy" {
  role       = aws_iam_role.shared_infra_deploy.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

module "budget" {
  source             = "./modules/budget"
  limit_usd          = var.budget_limit_usd
  alert_email        = var.alert_email
  target_role_arns   = var.budget_target_role_arns
  target_user_names  = var.budget_target_user_names
}
