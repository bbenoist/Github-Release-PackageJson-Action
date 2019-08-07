FROM ubuntu:18.04
LABEL "com.github.actions.name"="Github Package.json Release"
LABEL "com.github.actions.description"="Publish Github releases from package.json in an action"
LABEL "com.github.actions.icon"="git-branch"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/bbenoist/Github-Release-PackageJson-Action"
LABEL "maintainer"="Baptist BENOIST"

RUN apt-get update \
 && apt-get install software-properties-common -y --no-install-recommends \
      curl \
      git \
      jq
 && rm -rf /var/lib/apt/lists/*
 
 ARG HUB_VERSION="2.12.3"
 ARG HUB_URL="https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz"
 RUN curl "${HUB_URL}" | tar xzv -C / \
  && bash "/hub-linux-amd64-${HUB_VERSION}/install"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
