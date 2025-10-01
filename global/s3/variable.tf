variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "ap-northeast-2"
}
variable "prefix" {
  description = "The name of the prefix for resources"
  type        = string
  default     = "user00"
}
# variable "table_name" {
#   description = "The name of the DynamoDB table"
#   type        = string
#   default = "user00-terraform-locks"  
# }