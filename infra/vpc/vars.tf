variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = list
  default = ["10.0.0.0/20", "10.0.16.0/20"]
}
variable "private_subnet_cidr" {
  type    = list
  default = ["10.0.64.0/20", "10.0.80.0/20"]
}

variable "azs" {
    type = list
    default = ["ap-northeast-2a", "ap-northeast-2c"]
}