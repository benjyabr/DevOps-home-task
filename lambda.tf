data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role" "lambda" {
  name               = "lambda_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_cloudwatch_log_group" "first_lambda" {
  name = "/aws/lambda/${aws_lambda_function.first_lambda.function_name}"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "second_lambda" {
  name = "/aws/lambda/${aws_lambda_function.second_lambda.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_function" "first_lambda" {
  function_name = "firstLambdaFunction"
  package_type  = "Image"
  image_uri     = "jonathanpick/first-lambda:v1"
  role          = aws_iam_role.lambda.arn
}

resource "aws_lambda_function" "second_lambda" {
  function_name = "secondLambdaFunction"
  package_type  = "Image"
  image_uri     = "jonathanpick/second-lambda:v1"
  role          = aws_iam_role.lambda.arn
}
