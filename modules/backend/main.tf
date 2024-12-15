resource "aws_lambda_function" "sakano_lambda" {
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_exec.arn
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout
  filename      = var.lambda_zip_path

  tags = var.tags
}

resource "aws_api_gateway_rest_api" "sakano_api" {
  name = var.api_gateway_name

  tags = var.tags
}

resource "aws_api_gateway_resource" "qr_resource" {
  rest_api_id = aws_api_gateway_rest_api.sakano_api.id
  parent_id   = aws_api_gateway_rest_api.sakano_api.root_resource_id
  path_part   = "qr"
}

resource "aws_api_gateway_method" "qr_get" {
  rest_api_id   = aws_api_gateway_rest_api.sakano_api.id
  resource_id   = aws_api_gateway_resource.qr_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "qr_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sakano_api.id
  resource_id             = aws_api_gateway_resource.qr_resource.id
  http_method             = aws_api_gateway_method.qr_get.http_method
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
  uri                     = aws_lambda_function.sakano_lambda.invoke_arn
}

resource "aws_lambda_permission" "api_gateway_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sakano_lambda.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.sakano_api.execution_arn}/*/*"
}

output "api_url" {
  value = aws_api_gateway_rest_api.sakano_api.execution_invoke_url
}
