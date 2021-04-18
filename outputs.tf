output "appsync_id" {
  description = "ID of created appsync"
  value = aws_appsync_graphql_api.foe_api.id
}

output "appsync_graphqluri" {
  description = "ID of created appsync"
  value = aws_appsync_graphql_api.foe_api.uris["GRAPHQL"]
}

output "endpoint" {
  description = "The endpoint for the API."
  value       = data.external.graphql_endpoint.result["endpoint"]
}
