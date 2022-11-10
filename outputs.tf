output "api_url" {
  value = "${module.api.api_url}"
}

output "lambda_zip" {
  value = "${aws_s3_object.lambda_repo.key}"
}

# output "vpc_id" {
#   value = "${module.vpc_subnets.vpc_id}"
# }