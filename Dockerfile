FROM alpine:3.14

ENV VERSION=2.2.0

RUN apk update && \
    apk upgrade && \
    apk add --no-cache \
    git \
    jq

RUN wget https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_linux_386.tar.gz -O gh.tar.gz
RUN tar --strip-components=1 -xf gh.tar.gz

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]