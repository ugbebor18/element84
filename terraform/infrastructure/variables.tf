variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}


variable "datasets_bucket_name" {
  default = "my-unique-datasets-bucket"
}

variable "lambda_function_name" {
  default = "merge-homeless-data"
}

variable "api_gateway_name" {
  default = "HomelessDataAPI"
}
