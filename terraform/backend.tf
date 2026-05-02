# Bootstrap problem: this bucket is created by the state-backend module,
# but Terraform needs it to exist before it can store state here.
# First run: comment this block out, apply, then uncomment and run `terraform init`.
#terraform {
#  backend "s3" {
#    bucket         = "ethandeister-tfstate"
#    key            = "shared-infra/terraform.tfstate"
#    region         = "us-west-2"
#    dynamodb_table = "terraform-locks"
#  }
#}
