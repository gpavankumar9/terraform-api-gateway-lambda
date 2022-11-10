resource "aws_lambda_function" "lambda_function" {
  s3_bucket        = "${var.s3_bucket}"
  s3_key           = "${var.s3_key}"
  function_name    = "${var.function_name}"
  role             = "${var.role}"
  handler          = "${var.handler}"
  runtime          = "${var.runtime}"
  source_code_hash = "${var.hash}"
  memory_size      = "${var.memory}"
  environment {
    variables = {
      ENV = "dev"
    }
  }

}
