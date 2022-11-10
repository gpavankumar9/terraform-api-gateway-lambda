variable "region" {
  type = string
  default = "ap-south-1"
}

####################
# Tags
####################
variable "project" {
  description = "Project name for tags and resource naming"
  default = "DEMO"
}

variable "env" {
  description = "env name for tags and resource naming"
  default = "dev"
}

# #

####################
# VPC
####################
# variable vpc_cidr {
#   description = "VPC CIDR"
# }

# variable igw_cidr {
#   description = "VPC Internet Gateway CIDR"
# }

# variable public_subnets_cidr {
#   description = "Public Subnets CIDR"
#   type        = "list"
# }

# variable private_subnets_cidr {
#   description = "Private Subnets CIDR"
#   type        = "list"
#}

# variable nat_cidr {
#   description = "VPC NAT Gateway CIDR"
#   type        = "list"
# }

# variable azs {
#   description = "VPC Availability Zones"
#   type        = "list"
# }

####################
# Lambda
####################
variable "lambda_runtime" {
  description = "Lambda Function runtime"
  default = "python3.8"
}

# variable "lambda_zip_path" {
#   description = "Lambda Function Zipfile local path for S3 Upload"
# }

variable "lambda_function_name" {
  description = "Lambda Function Name"
  default     = "HelloLAMBDA"
}

variable "lambda_handler" {
  description = "Lambda Function Handler"
  default = "function.lambda_handler"
}

variable "lambda_memory" {
  description = "Lambda memory size, 128 MB to 3,008 MB, in 64 MB increments"
  default = "128"
}


####################
# API Gateway
####################

variable "account_id" {
  description = "Account ID needed to construct ARN to allow API Gateway to invoke lambda function"
  default = "187632786110"
}