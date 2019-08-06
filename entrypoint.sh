#!/bin/bash
set -x
set -e

MESSAGE=$*
jsonVersion=`jq -r ".version" package.json`

if GIT_DIR=.git git rev-parse "${jsonVersion}" >/dev/null 2>&1 ; then
    echo "Tag for version ${jsonVersion} already exists. No need to publish a new release."
else
    echo "No tag found for version ${jsonVersion}, creating a new GitHub release on ref ${GITHUB_REF}..."
    # https://github.com/github/hub/issues/1460
    echo "${MESSAGE}" > /tmp/release-message.txt
    hub release create -t "${GITHUB_REF}" -f /tmp/release-message.txt "${jsonVersion}"
    rm /tmp/release-message.txt
fi
