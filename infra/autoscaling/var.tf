variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "ap-northeast-2"
}
variable "prefix" {
  description = "Prefix for resource names."
  type        = string
  default     = "user00"
}
variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
  default     = "ami-0845ee48fd22cc61a"
}
variable "instance_type" {
  description = "The instance type for the EC2 instances."
  type        = string
  default     = "t2.micro"
}
variable "key_name" {
  description = "The name of the key pair to use for the instances."
  type        = string
  default     = "user00-key"
}