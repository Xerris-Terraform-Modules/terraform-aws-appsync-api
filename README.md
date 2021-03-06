# AWS Appsync API

https://registry.terraform.io/modules/Xerris-Terraform-Modules/appsync-api/aws/latest

This is designed to bootstrap an Appsync API with the ability to add direct lambda resolvers

## Example usage:

```
module "foe_api" {
    source = "github.com/xerris/aws-modules//lambdaSourceAppsync"
    name = "${var.env}-foe-api"
    schema = file("schema.graphql")

    env = var.env
    region = var.region
    account_id = var.account_id
    ecr_name = "foe_base"
    image_uri = var.image_tag
    cognito_id = aws_cognito_user_pool.primarypool.id

    resolvers = {
        "JobQueryResolver" = {
            description = "jobQuery"
            type = "Query"
            field = "getJob"
            entrypoint = "laprairie.foe::laprairie.foe.Handlers.JobHandler::GetAllJobs"
        }
    }
}
```


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| lambda_source | ./modules/lambda-appsync-resolver |  |

## Resources

| Name |
|------|
| [aws_appsync_graphql_api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_graphql_api) |
| [aws_ecr_repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cognito\_id | ID of Cognito -> Might Depricate and create cognito inside module later | `any` | n/a | yes |
| env | Environment of deployment | `any` | n/a | yes |
| image\_uri | URI of image to run all lambdas from | `any` | n/a | yes |
| name | Name of API | `any` | n/a | yes |
| region | Region for cognito | `string` | `"us-east-1"` | no |
| resolvers | Map of datasources to create | `any` | `{}` | no |
| schema | File path of graphql schema | `any` | n/a | yes |

## Outputs

No output.
