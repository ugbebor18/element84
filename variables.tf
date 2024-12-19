variable "backend_bucket_name" {
  description = "S3 bucket name for Terraform state"
  default     = "element84-terraform-state-assess"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  default     = "element84-terraform-locks-new"
}

variable "datasets_bucket_name" {
  description = "S3 bucket name for datasets"
  default     = "element84-datasets-assess"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  default     = "merge-homeless-data"
}

variable "api_gateway_name" {
  description = "Name of the API Gateway"
  default     = "HomelessDataAPI"
}

variable "aws_region" {
  description = "AWS region for all resources"
  default     = "us-east-1"
}
