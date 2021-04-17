
#!/usr/bin/env bash

# Exit if any of the intermediate steps fail
set -e

# Extract "api_id" argument from the input into
# API_ID shell variable.
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
EVAL=$(jq -r '@sh "API_ID=\(.api_id)"')
eval $EVAL

# Placeholder for whatever data-fetching logic your script implements
GRAPHQL=$(aws appsync get-graphql-api --api-id $API_ID | jq -r '.graphqlApi.uris.GRAPHQL')

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg graphql "$GRAPHQL" '{"endpoint":$graphql}'
