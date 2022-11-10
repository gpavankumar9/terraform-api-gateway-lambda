variable "name" {
  description = "The name of the REST API"
}

variable "stage_name" {
  description = "The stage name for the API deployment (production/staging/etc..)"
  default = "dev"
}

variable "method" {
  description = "The HTTP method"
  default     = "POST"
}

variable "path_part" {
  description = "resource"
  default     = "coverage"
}

variable "lambda" {
  description = "The lambda name to invoke"
}

variable "lambda_arn" {
  description = "The lambda arn to invoke"
}

variable "region" {
  description = "The AWS region, e.g., eu-west-1"
  default = "ap-south-1"
}

variable "account_id" {
  description = "The AWS account ID"
  default = "18763110"
}