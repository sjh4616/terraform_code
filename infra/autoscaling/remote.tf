data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "${var.prefix}-terraform-state"
    key    = "infra/vpc/terraform.tfstate"
    region = var.region
  }
}
data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "${var.prefix}-terraform-state"
    key    = "infra/sg/terraform.tfstate"
    region = var.region
  }
}
data "terraform_remote_state" "lb" {
  backend = "s3"
  config = {
    bucket = "${var.prefix}-terraform-state"
    key    = "infra/lb/terraform.tfstate"
    region = var.region
  }
}