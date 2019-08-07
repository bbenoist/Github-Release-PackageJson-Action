FROM ubuntu:18.04
LABEL "com.github.actions.name"="Github Package.json Release"
LABEL "com.github.actions.description"="Publish Github releases from package.json in an action"
LABEL "com.github.actions.icon"="git-branch"
LABEL "com.github.actions.color"="gray-dark"

LABEL "repository"="https://github.com/bbenoist/Github-Release-PackageJson-Action"
LABEL "maintainer"="Baptist BENOIST"

RUN apt-get update \
  && apt-get install software-properties-common -y --no-install-recommends \
  && add-apt-repository ppa:cpick/hub \
  && apt-get update \
  && apt-get install build-essential jq git -y --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*
 
 ARG HUB_VERSION="2.12.3"
 RUN curl "hub-linux-amd64-${HUB_VERSION}.tgz" | tar xzv -C / \
  && bash "/hub-linux-amd64-${HUB_VERSION}/install"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
