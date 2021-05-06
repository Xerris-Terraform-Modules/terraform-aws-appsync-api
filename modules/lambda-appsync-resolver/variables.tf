variable "function_name"{
    description = "Name of Resolver"
}
variable "description" {
    description = "Description of Resolver"
}
variable "type" {
    description = "Type of Resolver"
}
variable "field" {
    description = "Which field to resolve on"
}
variable "entrypoint" {
    description = "Entrypoint of code"
}
variable "env" {
    description = "Environment of deployment"
}
variable "image_uri" {
    description = "Image uri of container with lambda code"
}
variable "appsync_id" {
    description = "ID of Appsync to attach to"
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