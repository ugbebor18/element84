variable "backend_bucket_name" {
  description = "S3 bucket name for storing Terraform state"
  default     = "element84-terraform-state"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  default     = "element84-terraform-locks"
}

variable "datasets_bucket_name" {
  description = "S3 bucket name for storing datasets"
  default     = "element84-datasets"
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
