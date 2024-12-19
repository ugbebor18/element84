# Backend configuration variables
variable "backend_bucket_name" {
  description = "S3 bucket name for storing Terraform state"
  type        = string
  default     = "element84-terraform-state" 
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for state locking"
  type        = string
  default     = "element84-terraform-locks" 
}

variable "aws_region" {
  description = "AWS region for backend resources"
  type        = string
  default     = "us-east-1" 
}

# Lambda configuration variables
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "merge-homeless-data"
}

# Dataset bucket configuration variables
variable "datasets_bucket_name" {
  description = "S3 bucket name for storing datasets"
  type        = string
  default     = "element84-datasets" 
}

variable "s3_raw_data_path" {
  description = "Path in the S3 bucket for raw data files"
  type        = string
  default     = "raw/"
}

variable "s3_processed_data_path" {
  description = "Path in the S3 bucket for processed data files"
  type        = string
  default     = "processed/"
}

# API Gateway configuration variables
variable "api_gateway_name" {
  description = "Name of the API Gateway"
  type        = string
  default     = "HomelessDataAPI"
}
