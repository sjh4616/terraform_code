variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default = "user00-terraform-bucket"
}
variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
  default = "user00-terraform-locks"  
}