# infra-shared

Shared AWS infrastructure managed with Terraform. Applies automatically on merge to `main` via GitHub Actions.

## What's provisioned

- **DNS** — Route 53 hosted zone (imported from existing)
- **ACM** — Wildcard TLS certificate for the domain
- **OIDC** — GitHub Actions OIDC provider for keyless auth
- **State backend** — S3 bucket + DynamoDB table for Terraform state
- **CloudWatch** — Log group retention policy
- **Budget** — AWS cost alert with configurable limit and email

## Usage

PRs run `terraform plan`. Merges to `main` run `terraform apply`.

To apply locally:

```sh
cd terraform
terraform init
terraform plan
terraform apply
```

Required variables (set in `terraform.tfvars` or env):

| Variable | Description |
|---|---|
| `domain_name` | Root domain managed in Route 53 |
| `existing_zone_id` | ID of the existing hosted zone to import |
| `state_bucket_name` | S3 bucket name for Terraform state |
| `alert_email` | Email for budget alerts |
| `github_repo` | GitHub repo (`owner/name`) used for OIDC trust policy |

> **Note:** `state_bucket_name` is also hardcoded in `backend.tf` — Terraform does not support variable interpolation in backend blocks, so these must be kept in sync manually.
