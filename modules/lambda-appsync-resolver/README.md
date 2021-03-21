# AWS Appsync API

This create and attached a resolver to an AWS Appsync API


## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_appsync_datasource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_datasource) |
| [aws_appsync_resolver](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appsync_resolver) |
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| [aws_lambda_function](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| appsync\_id | ID of Appsync to attach to | `any` | n/a | yes |
| description | Description of Resolver | `any` | n/a | yes |
| entrypoint | Entrypoint of code | `any` | n/a | yes |
| field | Which field to resolve on | `any` | n/a | yes |
| function\_name | Name of Resolver | `any` | n/a | yes |
| image\_uri | Image uri of container with lambda code | `any` | n/a | yes |
| type | Type of Resolver | `any` | n/a | yes |

## Outputs

No output.
