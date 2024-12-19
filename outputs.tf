# Outputs for backend resources
output "terraform_state_bucket" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "S3 bucket name for storing Terraform state"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "DynamoDB table name for Terraform state locking"
}

# Outputs for dataset resources
output "datasets_bucket" {
  value       = aws_s3_bucket.datasets.bucket
  description = "S3 bucket name for storing datasets"
}

# Outputs for Lambda function
output "lambda_function_name" {
  value       = aws_lambda_function.merge_function.function_name
  description = "Name of the Lambda function"
}

# Outputs for API Gateway
output "api_gateway_url" {
  value       = aws_apigatewayv2_stage.default_stage.invoke_url
  description = "API Gateway URL for accessing the merged dataset"
}
