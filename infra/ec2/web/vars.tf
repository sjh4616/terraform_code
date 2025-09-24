variable "region" {
  type    = string
  default = "ap-northeast-2"
}
variable "vpc_id" {
  type    = string
  default = "vpc-028d49c644e3f54e7"
}
variable "public_subnet_id" {
  type    = list
  default = ["subnet-05b7c43e9919c62d1", "subnet-082ad86cdbf050f10"]  
}
variable "private_subnet_id" {
  type    = list
  default = ["subnet-0c5a97c2b08d3b955", "subnet-0e0ebee087203b4f1"]
}
