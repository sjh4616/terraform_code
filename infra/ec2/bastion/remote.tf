data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "${var.prefix}-terraform-state"
    key    = "infra/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
data "terraform_remote_state" "sg" {
  backend = "s3"
  config = {
    bucket = "${var.prefix}-terraform-state"
    key    = "infra/sg/terraform.tfstate"
    region = "ap-northeast-2"
  }
}