FROM alpine:3.14

RUN set -x && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk add kubectl@testing curl jq

COPY ./*.sh /test/e2e/
COPY ./manifest/*.yaml /test/e2e/manifest/

WORKDIR /test/e2e

