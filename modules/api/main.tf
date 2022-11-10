resource "aws_api_gateway_rest_api" "apiLambda" {
  name        = "myAPI"
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.apiLambda.id}"
  parent_id   = "${aws_api_gateway_rest_api.apiLambda.root_resource_id}"
  path_part   = "${var.path_part}"
}

resource "aws_api_gateway_method" "api_method" {
  rest_api_id   = "${aws_api_gateway_rest_api.apiLambda.id}"
  resource_id   = "${aws_api_gateway_resource.api_resource.id}"
  http_method   = "${var.method}"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "api_method_integration" {
  rest_api_id             = "${aws_api_gateway_rest_api.apiLambda.id}"
  resource_id             = "${aws_api_gateway_resource.api_resource.id}"
  http_method             = "${aws_api_gateway_method.api_method.http_method}"
  type                    = "AWS_PROXY"
  uri                     = "${var.lambda_arn}"
  integration_http_method = "POST"
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_method.api_method,
    aws_api_gateway_integration.api_method_integration,
  ]

  rest_api_id = "${aws_api_gateway_rest_api.apiLambda.id}"
  stage_name  = "${var.stage_name}"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${var.lambda}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.apiLambda.id}/${aws_api_gateway_deployment.deployment.stage_name}/*"
}