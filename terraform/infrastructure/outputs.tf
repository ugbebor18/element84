output "datasets_bucket_name" {
  value = aws_s3_bucket.datasets.bucket
}

output "lambda_function_name" {
  value = aws_lambda_function.merge_function.function_name
}
