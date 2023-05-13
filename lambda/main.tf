provider "aws" {
  region = var.aws_region
}

resource "aws_lambda_function" "example_lambda" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.filename
  role          = aws_iam_role.lambda_role.arn
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Environment = "Production"
  }
}