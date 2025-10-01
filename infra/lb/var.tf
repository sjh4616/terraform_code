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
variable "key_name" {
  description = "The name of the key pair to use for the instances."
  type        = string
  default     = "user00-key"
}