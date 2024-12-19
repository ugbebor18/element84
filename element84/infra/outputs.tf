output "api_gateway_url" {
  value       = aws_apigatewayv2_stage.default_stage.invoke_url
  description = "API Gateway URL for accessing the merged dataset"
}

output "terraform_state_bucket" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "S3 bucket name for storing Terraform state"
}

output "datasets_bucket" {
  value       = aws_s3_bucket.datasets.bucket
  description = "S3 bucket name for storing datasets"
}

output "dynamodb_table" {
  value       = aws_dynamodb_table.terraform_locks.name
  description = "Name of the DynamoDB table used for Terraform state locking"
}

output "lambda_function_name" {
  value       = aws_lambda_function.merge_function.function_name
  description = "Name of the Lambda function"
}
