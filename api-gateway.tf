resource "aws_api_gateway_rest_api" "my_lambda_demo" {
  name        = "my_lambda_demo"
  description = "Example API"
}

resource "aws_api_gateway_resource" "first_lambda" {
  rest_api_id = aws_api_gateway_rest_api.my_lambda_demo.id
  parent_id   = aws_api_gateway_rest_api.my_lambda_demo.root_resource_id
  path_part   = "first-lambda"
}

resource "aws_api_gateway_method" "first_lambda" {
  rest_api_id   = aws_api_gateway_rest_api.my_lambda_demo.id
  resource_id   = aws_api_gateway_resource.first_lambda.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "first_lambda" {
  rest_api_id = aws_api_gateway_rest_api.my_lambda_demo.id
  resource_id = aws_api_gateway_resource.first_lambda.id
  http_method = aws_api_gateway_method.first_lambda.http_method
  integration_http_method = "POST" # Lambda functions are invoked with POST
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.first_lambda.invoke_arn
}

resource "aws_lambda_permission" "first_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.first_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  # The source ARN specifies that only the specified API Gateway can invoke the function
  source_arn = "${aws_api_gateway_rest_api.my_lambda_demo.execution_arn}/*/*/*"
}

resource "aws_api_gateway_resource" "second_lambda" {
  rest_api_id = aws_api_gateway_rest_api.my_lambda_demo.id
  parent_id   = aws_api_gateway_rest_api.my_lambda_demo.root_resource_id
  path_part   = "second-lambda"
}

resource "aws_api_gateway_method" "second_lambda" {
  rest_api_id   = aws_api_gateway_rest_api.my_lambda_demo.id
  resource_id   = aws_api_gateway_resource.second_lambda.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "second_lambda" {
  rest_api_id = aws_api_gateway_rest_api.my_lambda_demo.id
  resource_id = aws_api_gateway_resource.second_lambda.id
  http_method = aws_api_gateway_method.first_lambda.http_method
  integration_http_method = "POST" # Lambda functions are invoked with POST
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.second_lambda.invoke_arn
}

resource "aws_lambda_permission" "second_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.second_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  # The source ARN specifies that only the specified API Gateway can invoke the function
  source_arn = "${aws_api_gateway_rest_api.my_lambda_demo.execution_arn}/*/*/*"
}

resource "aws_api_gateway_deployment" "my_demo" {
  depends_on = [
    aws_api_gateway_integration.first_lambda,
    aws_api_gateway_integration.second_lambda
  ]
  rest_api_id = aws_api_gateway_rest_api.my_lambda_demo.id
  stage_name  = "test"
}
