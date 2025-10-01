variable "region" {
  type    = string
  default = "ap-northeast-2"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "user00-key"
}
variable "prefix" {
  type    = string
  default = "user00"
}
