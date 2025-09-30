provider "aws" {
  region = "us-west-1"
}
provider "aws" {
  alias  = "seoul"
  region = "ap-northeast-2"
}
module "ec2_california" {
  source        = "../modules/terraform-aws-ec2"
}
module "ec2_seoul" {
  source        = "../modules/terraform-aws-ec2"
  providers = {
    aws = aws.seoul
  }
  instance_type = "t2.nano" 
}