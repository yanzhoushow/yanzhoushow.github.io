provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
}

resource "aws_lambda_function" "example" {
  function_name = "helloworld-lambda"

  # The bucket name as created earlier with "aws s3api create-bucket"
  s3_bucket = "x-terraform-lambda"
  s3_key    = "v1.0.0/helloworld.zip"

  # "main": filename within the zip file (main.py)
  # "lambda_handler": name of the property under which the handler function
  handler = "main.lambda_handler"
  runtime = "python3.8"

  role = aws_iam_role.lambda_exec.arn
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

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

resource "aws_api_gateway_rest_api" "example" {
  name = "example"
  description = "example gateway"
}

resource "aws_api_gateway_resource" "resources" {
  rest_api_id = aws_api_gateway_rest_api.example.id
  parent_id   = aws_api_gateway_rest_api.example.root_resource_id
  path_part   = "resourses"
}

resource "aws_api_gateway_method" "methods" {
  rest_api_id = aws_api_gateway_resource.resources.rest_api_id
  resource_id = aws_api_gateway_resource.resources.id
  http_method = "GET"
  authorization = "None"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_resource.resources.rest_api_id
  resource_id = aws_api_gateway_resource.resources.id
  http_method = aws_api_gateway_method.methods.http_method
  integration_http_method = "GET"
  type = "AWS_PROXY"
  uri = aws_lambda_function.example.invoke_arn
}


