terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "user00-terraform-state"
    key            = "infra/vpc/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "user00-terraform-locks"
    encrypt        = true
  }
}