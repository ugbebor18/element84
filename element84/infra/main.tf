terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # Backend configuration is in a separate backend.tf file
}

provider "aws" {
  region = "us-east-1"
}

# Step 1: S3 Bucket for Terraform State
resource "aws_s3_bucket" "terraform_state" {
  bucket = "element84-terraform-state"

  tags = {
    Name = "Terraform State Bucket"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "element84-terraform-locks"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform Lock Table"
  }
}

# Step 2: S3 Bucket for Datasets
resource "aws_s3_bucket" "datasets" {
  bucket = "element84-datasets"

  tags = {
    Name = "Dataset Bucket"
  }
}

# Step 3: IAM Role for Lambda
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

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

# Step 4: Lambda Function
resource "aws_lambda_function" "merge_function" {
  function_name = "merge-homeless-data"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "lambda_function.lambda_handler"
  filename      = "lambda_function.zip" # Lambda function zip file

  environment {
    variables = {
      S3_BUCKET_NAME = aws_s3_bucket.datasets.id
    }
  }

  depends_on = [aws_s3_bucket.datasets, aws_iam_role.lambda_exec] # Ensure dependencies
}

# Step 5: API Gateway
resource "aws_apigatewayv2_api" "http_api" {
  name          = "HomelessDataAPI"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id             = aws_apigatewayv2_api.http_api.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.merge_function.invoke_arn
  payload_format_version = "2.0"

  depends_on = [aws_lambda_function.merge_function]
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /data"
  target    = aws_apigatewayv2_integration.lambda_integration.id
}

resource "aws_apigatewayv2_stage" "default_stage" {
  api_id = aws_apigatewayv2_api.http_api.id
  name   = "$default"
  auto_deploy = true
}

# Outputs
output "api_gateway_url" {
  value       = aws_apigatewayv2_stage.default_stage.invoke_url
  description = "API Gateway URL for accessing merged dataset"
}
