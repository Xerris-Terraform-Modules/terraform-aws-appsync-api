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
variable "image_uri" {
    description = "Image uri of container with lambda code"
}
variable "appsync_id" {
    description = "ID of Appsync to attach to"
}