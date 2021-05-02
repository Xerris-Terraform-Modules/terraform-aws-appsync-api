variable "region" {
    default = "us-east-1"
    description = "Region for cognito"
}
variable "env" {
    description = "Environment of deployment"
}
variable "image_uri" {
    description = "URI of image to run all lambdas from"
}

variable "resolvers" {
  description = "Map of datasources to create"
  type        = any
  default     = {}
}

variable "name" {
    description = "Name of API"
}
variable "cognito_id" {
    description = "ID of Cognito -> Might Depricate and create cognito inside module later"
}
variable "schema" {
    description = "File path of graphql schema"
}

variable "ecr_url"{
    default = ""
    description = "ECR url"
}

///////IAM Variables//////////////////////////////////////////////////
variable "s3_readwrite_arn_iam_list" {
    default     = []
    type        = list(string)
    description = "List of the s3 arns you want the lambda to have read/write iam access to."
}
variable "s3_read_arn_iam_list" {
    default     = []
    type        = list(string)
    description = "List of the s3 arns you want the lambda to have read iam access to."
}
variable "sqs_arn_iam_list" {
    default     = []
    type        = list(string)
    description = "List of the sqs arns you want the lambda to have iam access to."
}
variable "dynamodb_readwrite_arn_iam_list" {
    default     = []
    type        = list(string)
    description = "List of the dynamodb arns you want the lambda to have read/write iam access to."
}
variable "dynamodb_read_arn_iam_list" {
    default     = []
    type        = list(string)
    description = "List of the dynamodb arns you want the lambda to have read iam access to."
}
variable "secretsmanager_arn_iam_list" {
    default     = []
    type        = list(string)
    description = "List of the secretsmanager arns you want the lambda to have iam access to."
}
variable "lambda_arn_iam_list" {
    default     = []
    type        = list(string)
    description = "List of the lambda arns you want the lambda to have iam access to. Probably will depricate, use with caution"
}
////////Private Networking Variables//////////////////////////////////////////////////
variable "subnet_ids" {
    default     = null
    type        = list(string)
    description = "List of the subnet ids you want the lambda to reside in."
}
variable "vpc_security_group_ids" {
    default     = null
    type        = list(string)
    description = "List of the security group ids you want the lambda to reside in."
}