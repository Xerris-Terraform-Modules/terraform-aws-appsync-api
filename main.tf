resource "aws_appsync_graphql_api" "foe_api" {
  name = var.name
  schema = var.schema
  authentication_type = "AMAZON_COGNITO_USER_POOLS"
  user_pool_config {
    aws_region     = var.region
    default_action = "ALLOW"
    user_pool_id   = var.cognito_id
  }
}

module "lambda_source" {
    for_each = var.resolvers

    source = "./modules/lambda-appsync-resolver"
    image_uri = "${var.ecr_url}:${var.image_uri}"

    function_name = each.key
    description = lookup(each.value, "description", null)
    type = lookup(each.value, "type", null)
    dynamodb_readwrite_arn_iam_list = lookup(each.value, "dynamodb_readwrite_arn_iam_list", [])
    dynamodb_read_arn_iam_list = lookup(each.value, "dynamodb_read_arn_iam_list", [])
    s3_readwrite_arn_iam_list = lookup(each.value, "s3_readwrite_arn_iam_list", [])
    s3_read_arn_iam_list = lookup(each.value, "s3_read_arn_iam_list", [])
    sqs_arn_iam_list = lookup(each.value, "sqs_arn_iam_list", [])
    secretsmanager_arn_iam_list = lookup(each.value, "secretsmanager_arn_iam_list", [])
    lambda_arn_iam_list = lookup(each.value, "lambda_arn_iam_list", [])
    field = lookup(each.value, "field", null)
    entrypoint = lookup(each.value, "entrypoint", null)
    subnet_ids = lookup(each.value, "subnet_ids", null)
    vpc_security_group_ids = lookup(each.value, "vpc_security_group_ids", null)
    appsync_id = aws_appsync_graphql_api.foe_api.id
}
