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
  && apt-get install build-essential jq git golang-go -y --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

ENV GOPATH=/go
RUN mkdir -p "${GOPATH}/src/github.com/github"
RUN git clone \
  --config transfer.fsckobjects=false \
  --config receive.fsckobjects=false \
  --config fetch.fsckobjects=false \
  https://github.com/github/hub.git "${GOPATH}/src/github.com/github/hub"
RUN cd "$GOPATH/src/github.com/github/hub" && make install prefix=/usr/local

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
