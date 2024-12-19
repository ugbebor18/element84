variable "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "element84-terraform-state"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for Terraform state locking"
  type        = string
  default     = "element84-terraform-locks"
}

variable "datasets_bucket_name" {
  description = "Name of the S3 bucket for storing datasets"
  type        = string
  default     = "element84-datasets"
}

variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "merge-homeless-data"
}

variable "api_gateway_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "HomelessDataAPI"
}
