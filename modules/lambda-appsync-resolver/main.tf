resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "role_policy" {
  name = "${var.function_name}_role_policy"
  role = aws_iam_role.lambda_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "lambda:InvokeFunction"
            ],
            "Resource": "${aws_lambda_function.appsync_lambda.arn}"
        }
    ]
}
EOF
}

resource "aws_appsync_datasource" "lambda_datasource" {
  api_id           = var.appsync_id
  name             = "${var.function_name}datasource"
  service_role_arn = aws_iam_role.lambda_role.arn
  type             = "AWS_LAMBDA"

  lambda_config {
    function_arn = aws_lambda_function.appsync_lambda.arn
  }
}

resource "aws_appsync_resolver" "lambda_resolver" {
  type              = var.type
  api_id            = var.appsync_id
  field             = var.field
  data_source       = aws_appsync_datasource.lambda_datasource.name
  request_template = <<EOF
{
    "version" : "2017-02-28",
    "operation": "Invoke",
    "payload": $util.toJson($context)
}
EOF
  response_template = "$util.toJson($ctx.result)"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "${var.function_name}iamrole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    effect = "Allow"
    actions = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = ["*"]
  }
  dynamic "statement" {
    for_each = var.s3_readwrite_arn_iam_list 
    content {
        effect = "Allow"
        actions = [
      "s3:HeadBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:ListBucket"
        ]
        resources = [
        statement.value,
        "${statement.value}/*",
        ]
    }
  }
  dynamic "statement" {
    for_each = var.s3_read_arn_iam_list 
    content {
        effect = "Allow"
        actions = [
      "s3:HeadBucket",
      "s3:GetObject",
      "s3:ListBucket"
        ]
        resources = [
        statement.value,
        "${statement.value}/*",
        ]
    }
  }
  dynamic "statement" {
    for_each = var.dynamodb_readwrite_arn_iam_list 
    content {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:DescribeTable"
    ]
    resources = [statement.value]
    }
  }
    dynamic "statement" {
    for_each = var.dynamodb_read_arn_iam_list 
    content {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:Query",
      "dynamodb:DescribeTable"
    ]
    resources = [statement.value]
    }
  }
  dynamic "statement" {
    for_each = var.sqs_arn_iam_list 
    content {
    effect = "Allow"
    actions = [
      "sqs:ReceiveMessage",
      "sqs:GetQueueAttributes",
      "sqs:DeleteMessage",
    ]
    resources = [statement.value]
    }
  }
  dynamic "statement" {
    for_each = var.lambda_arn_iam_list 
    content {
    effect = "Allow"
    actions = [
      "lambda:*",
    ]
    resources = [statement.value]
    }
  }
}
resource "aws_iam_policy" "lambda_policy" {
  name   = var.function_name
  policy = data.aws_iam_policy_document.lambda_policy_document.json
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role      = aws_iam_role.iam_for_lambda.name
  policy_arn    = aws_iam_policy.lambda_policy.arn
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = ["aws_iam_role_policy_attachment.lambda_logs"]

  create_duration = "16s"
}

resource "aws_lambda_function" "appsync_lambda" {
  depends_on = ["time_sleep.wait_30_seconds"]
  function_name        = var.function_name
  description          = var.description
  timeout              = 30
  role                 = aws_iam_role.iam_for_lambda.arn
  image_config  {
      command          = [var.entrypoint]
  }
  image_uri            = var.image_uri
  package_type         = "Image"
  
  
  vpc_config {
    ##for_each = var.subnet_ids != [] && var.vpc_security_group_ids != [] ? [true] : []
    
    subnet_ids       = var.subnet_ids == [] ? [] : var.subnet_ids
    security_group_ids  = var.vpc_security_group_ids == [] ? [] : var.vpc_security_group_ids
    
  }
}
