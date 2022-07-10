
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../bin/main"
  output_path = "bin/function.zip"
}

resource "aws_iam_role" "lambda_execution_role" {
  name = var.lambda_role_name
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda_function" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_execution_role.arn
  runtime       = var.lambda_runtime
  handler       = var.lambda_handler
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout

  source_code_hash  = filebase64sha256(data.archive_file.lambda_zip.output_path)

  dynamic "environment" {
    for_each = var.lambda_environment_variables
    content {
      variables = environment.value.variables
    }
  }

  tags = merge(
    var.lambda_additional_tags,
    {
      Name = var.lambda_function_name
    },
  )
}
