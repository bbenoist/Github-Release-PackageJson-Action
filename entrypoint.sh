#!/bin/bash
set -e

MESSAGE=$*
jsonVersion=`jq -r ".version" package.json`

if GIT_DIR=.git git rev-parse "${jsonVersion}" >/dev/null 2>&1 ; then
    echo "Tag for version ${jsonVersion} already exists. No need to publish a new release."
else
    echo "No tag found for version ${jsonVersion}, creating a new GitHub release..."
    
    # https://github.com/github/hub/issues/2149#issuecomment-496880225
    mkdir -p "${HOME}/.config"
    echo "github.com:\n- user: ${GITHUB_ACTOR}\n  oauth_token: ${GITHUB_TOKEN}\n  protocol: https\n" > "${HOME}/.config/hub"
    unset GITHUB_TOKEN
    cat "${HOME}/.config/hub"

    HUB_CONFIG="${HOME}/.config/hub" hub release create -m "${MESSAGE}" "${jsonVersion}"
fi
