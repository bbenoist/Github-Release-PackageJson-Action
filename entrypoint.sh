#!/bin/bash
set -e

MESSAGE=$*
jsonVersion=`jq -r ".version" package.json`

if GIT_DIR=.git git rev-parse "${jsonVersion}" >/dev/null 2>&1 ; then
    echo "Tag for version ${jsonVersion} already exists. No need to publish a new release."
else
    echo "No tag found for version ${jsonVersion}, creating a new GitHub release..."
    
    echo ${GITHUB_TOKEN}
    hub --version
    if [[ -f $HOME/.config/hub ]]; then cat $HOME/.config/hub ; fi
    
    # https://github.com/github/hub/issues/2149#issuecomment-496880225
    # export GITHUB_USER=bot
    hub release create -m "${MESSAGE}" "${jsonVersion}"
fi
