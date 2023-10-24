#!/usr/bin/env python3

import jwt
import os
import requests
import time


def main():

    gh_app_id = os.environ.get("GITHUB_APP_ID")
    gh_app_pk_file = os.environ.get("GITHUB_APP_PK_FILE")
    gh_org = os.environ.get("GITHUB_ORG")

    if not gh_app_id or not gh_app_pk_file or not gh_org:
        raise ValueError("Environment variables GITHUB_APP_ID, GITHUB_APP_PK_FILE and GITHUB_ORG must be passed to this program.")

    jwt_token = get_jwt_token(gh_app_id, gh_app_pk_file)
    installation_id = get_installation_id(jwt_token, gh_org)
    access_token = get_access_token(jwt_token, installation_id)

    print(f"GITHUB_TOKEN={access_token}")


def get_jwt_token(gh_app_id, gh_app_pk_file):

    with open(gh_app_pk_file, "rb") as file:
        private_key = file.read()
    payload = {"iat": int(time.time()), "exp": int(time.time()) + 600, "iss": gh_app_id}
    jwt_token = jwt.encode(payload, private_key, algorithm="RS256")

    return jwt_token


def get_installation_id(jwt_token, gh_org):

    headers = {
        "Authorization": f"Bearer {jwt_token}",
        "Accept": "application/vnd.github.v3+json",
    }
    url = "https://api.github.com/app/installations"
    response = requests.get(url, headers=headers)

    installation_id = None
    for installation in response.json():
        if installation["account"]["login"] == gh_org:
            installation_id = installation["id"]
            break

    return installation_id


def get_access_token(jwt_token, installation_id):

    headers = {
        "Authorization": f"Bearer {jwt_token}",
        "Accept": "application/vnd.github.v3+json",
    }
    url = f"https://api.github.com/app/installations/{installation_id}/access_tokens"
    response = requests.post(url, headers=headers)

    return response.json().get("token")


if __name__ == "__main__":
    main()
