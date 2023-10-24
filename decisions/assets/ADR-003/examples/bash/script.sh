#!/bin/bash

function main() {

  if [[ -z "$GITHUB_APP_ID" || -z "$GITHUB_APP_PK_FILE" || -z "$GITHUB_ORG" ]]; then
    echo "Environment variables GITHUB_APP_ID, GITHUB_APP_PK_FILE and GITHUB_ORG must be passed to this program."
    exit 1
  fi

  jwt_token=$(get-jwt-token)
  installation_id=$(get-installation-id)
  access_token=$(get-access-token)

  echo "GITHUB_TOKEN=$access_token"
}

function get-jwt-token() {

  header=$(echo -n '{"alg":"RS256","typ":"JWT"}' | base64 | tr -d '=' | tr -d '\n=' | tr -- '+/' '-_')
  payload=$(echo -n '{"iat":'"$(date +%s)"',"exp":'$(($(date +%s)+600))',"iss":"'"$GITHUB_APP_ID"'"}' | base64 | tr -d '\n=' | tr -- '+/' '-_')
  signature=$(echo -n "$header.$payload" | openssl dgst -binary -sha256 -sign "$GITHUB_APP_PK_FILE" | openssl base64 | tr -d '\n=' | tr -- '+/' '-_')

  echo "$header.$payload.$signature"
}

function get-installation-id() {

  installations_response=$(curl -sX GET \
    -H "Authorization: Bearer $jwt_token" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/app/installations)

  echo "$installations_response" | jq '.[] | select(.account.login == "'"$GITHUB_ORG"'") .id'
}

function get-access-token() {

  token_response=$(curl -sX POST \
    -H "Authorization: Bearer $jwt_token" \
    -H "Accept: application/vnd.github.v3+json" \
    "https://api.github.com/app/installations/$installation_id/access_tokens")

  echo "$token_response" | jq .token -r
}

main
