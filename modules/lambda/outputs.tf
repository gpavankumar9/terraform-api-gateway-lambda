output "name" {
  value = "${aws_lambda_function.lambda_function.function_name}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.lambda_function.invoke_arn}"
}

output "version" {
  value = "${aws_lambda_function.lambda_function.version}"
}