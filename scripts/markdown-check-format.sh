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
  image=ghcr.io/igorshubovych/markdownlint-cli@sha256:df7ce7cdcdb525d52a89d7aab17c507d49adceaddf2b767d3ed799c9537ded80 # v0.32.2
  docker run --rm \
    -v $PWD:/workdir \
    $image \
      $files \
      --disable MD013 MD033
fi
