ARG ALPINE_VERSION=latest

FROM alpine:${ALPINE_VERSION} as base
WORKDIR /opt/resource

RUN apk add --no-cache curl jq

COPY src/ ./
