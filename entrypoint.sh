#!/bin/sh -l

set -u

echo "$2" > .githubtoken
unset GITHUB_TOKEN

gh auth login --with-token < .githubtoken
rm .githubtoken

id=$(
    jq \
        --arg environment "$1" \
        --arg ref $GITHUB_REF \
        -n '{
            "environment": $environment,
            "ref": $ref,
            "required_contexts":[]
            }' \
    | gh api \
        repos/$GITHUB_REPOSITORY/deployments --input - \
        -H "Accept: application/vnd.github.ant-man-preview+json" \
    | jq .id
)

echo "::set-output name=id::$id"