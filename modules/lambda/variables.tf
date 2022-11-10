variable "function_name" {
  description = "The name of the lambda function"
}

variable "runtime" {
  description = "The runtime of the lambda to create"
  default = "python3.8"
}

variable "s3_bucket" {
  description = "Dist s3 bucket"
}

variable "s3_key" {
  description = "The filename of the lambda zip in s3 bucket"
}

variable "hash" {
  description = "The file hash"
}

variable "handler" {
  description = "The handler name of the lambda function"
}

variable "memory" {
  description = "The memory size of the lambda function"
}

variable "role" {
  description = "IAM role attached to the Lambda Function (ARN)"
}