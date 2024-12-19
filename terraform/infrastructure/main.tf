resource "aws_s3_bucket" "datasets" {
  bucket = var.datasets_bucket_name

  tags = {
    Name = "Datasets Bucket"
  }
}

resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_lambda_function" "merge_function" {
  function_name = var.lambda_function_name
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  filename      = "lambda_function.zip"

  environment {
    variables = {
      S3_BUCKET_NAME = aws_s3_bucket.datasets.id
    }
  }
}

resource "aws_apigatewayv2_api" "http_api" {
  name          = var.api_gateway_name
  protocol_type = "HTTP"
}
