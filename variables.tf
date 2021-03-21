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