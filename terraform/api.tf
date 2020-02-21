provider "aws" {
  access_key = ""
  secret_key = ""
  region = "us-east-1"
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

