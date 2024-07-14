output first_lambda_invoke_url {
  value = "${replace(aws_api_gateway_deployment.my_demo.invoke_url,".us-east-1.amazonaws.com/",".localhost.localstack.cloud:4566/")}${aws_api_gateway_resource.first_lambda.path}"
}
output first_lambda_invoke_url_localstack {
  value = "${replace(aws_api_gateway_deployment.my_demo.invoke_url,".us-east-1.amazonaws.com/",".localhost.localstack.cloud:4566/")}${aws_api_gateway_resource.first_lambda.path}"
}
output second_lambda_invoke_url {
  value = "${replace(aws_api_gateway_deployment.my_demo.invoke_url,".us-east-1.amazonaws.com/",".localhost.localstack.cloud:4566/")}${aws_api_gateway_resource.second_lambda.path}"
}
output second_lambda_invoke_url_localstack {
  value = "${replace(aws_api_gateway_deployment.my_demo.invoke_url,".us-east-1.amazonaws.com/",".localhost.localstack.cloud:4566/")}${aws_api_gateway_resource.second_lambda.path}"
}