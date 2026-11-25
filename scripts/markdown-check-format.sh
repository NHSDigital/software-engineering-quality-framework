#!/bin/bash

# Check Markdown formating of all the "*.md" files that are changed and commited to the current branch.
#
# Usage:
#   $ [options] ./markdown-check-format.sh
#
# Options:
#   BRANCH_NAME=other-branch-than-main  # Branch to compare with

# Please, make sure to enable Markdown linting in your IDE. For the Visual Studio Code editor it is
# `davidanson.vscode-markdownlint` that is already specified in the `.vscode/extensions.json` file.

files=$((git diff --diff-filter=ACMRT --name-only origin/${BRANCH_NAME:-main}.. "*.md"; git diff --name-only "*.md") | sort | uniq)
if [ -n "$files" ]; then
  image=ghcr.io/igorshubovych/markdownlint-cli@sha256:905baf9f6bd11da2ede8c394882c616509385f24b8b8d54fff6e111be88f39de # v0.49.1
  docker run --rm \
    -v $PWD:/workdir \
    $image \
      $files \
      --disable MD013 MD033 MD055 MD056 MD058 MD059 MD060
fi
