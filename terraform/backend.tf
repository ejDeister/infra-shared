terraform {
  backend "s3" {
    bucket         = "ethandeister-tfstate"
    key            = "shared-infra/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
  }
}
