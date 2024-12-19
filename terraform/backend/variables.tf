variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}


variable "backend_bucket_name" {
  default = "my-unique-terraform-state-bucket"
}

variable "dynamodb_table_name" {
  default = "my-unique-terraform-locks"
}
