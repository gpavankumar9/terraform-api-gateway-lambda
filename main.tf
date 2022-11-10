terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

terraform {
 backend "s3" {
   bucket         = "pavan-terraform-tfstate"
   key            = "state/terraform.tfstate"
   region         =  "ap-south-1"
   encrypt        = true
   profile        = "LOCAL"
 }
}

# Configure the AWS Provider
provider "aws" {
  region =  "ap-south-1"
  shared_config_files      = ["C:/Users/GORPUPA1/.aws/config"]
  shared_credentials_files = ["C:/Users/GORPUPA1/.aws/credentials"]
  profile = "LOCAL"
}

# Create a VPC
resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/16"
}

#Create S3 bucket for lambda build aftifacts
resource "aws_s3_bucket" "lambda_repo" {
  bucket = "pavan-lambda-repo-build-artifacts"
}

####################
# API
####################
module "api" {
  name       = "my-first-api"
  source     = "./modules/api"
  method     = "ANY"
  lambda     = "${module.lambda.name}"
  lambda_arn = "${module.lambda.lambda_arn}"
  region     = "${var.region}"
  account_id = "${var.account_id}"
  stage_name = "${var.env}"
}

####################
# Lambda
####################
module "lambda" {
  source        = "./modules/lambda"
  s3_bucket     = "${aws_s3_bucket.lambda_repo.bucket}"
  s3_key        = "${aws_s3_object.lambda_repo.key}"
  hash          = "${data.archive_file.lambda_hello.output_base64sha256}" 
  function_name = "${var.project}-${var.env}-${var.lambda_function_name}"
  handler       = "${var.lambda_handler}"
  runtime       = "${var.lambda_runtime}"
  role          = "${aws_iam_role.hello_lambda_exec.arn}"
  memory        = "${var.lambda_memory}"

  # database_uri  = "${module.rds_instance.url}"

  # subnet_ids         = ["${module.vpc_subnets.nat_subnet_id}"]
  # security_group_ids = ["${aws_security_group.all.id}"]
}

resource "aws_iam_role" "hello_lambda_exec" {
  name = "hello-lambda"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "hello_lambda_policy" {
  role       = aws_iam_role.hello_lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


data "archive_file" "lambda_hello" {
  type = "zip"

  source_dir  = "./modules/lambda/code"
  output_path = "./modules/lambda/hello.zip"
}

resource "aws_s3_object" "lambda_repo" {
  bucket = aws_s3_bucket.lambda_repo.id

  key    = "hello.zip"
  source = data.archive_file.lambda_hello.output_path

  etag = filemd5(data.archive_file.lambda_hello.output_path)
}
