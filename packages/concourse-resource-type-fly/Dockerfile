ARG CONCOURSE_VERSION

########################################
FROM concourse/concourse:${CONCOURSE_VERSION} AS concourse
WORKDIR /usr/local/concourse/fly-assets

RUN tar -xzvf fly-linux-amd64.tgz

########################################
FROM alpine:3.18 AS runtime
WORKDIR /opt/resource

RUN apk add --no-cache bash jq

COPY --from=concourse /usr/local/concourse/fly-assets/fly /usr/local/bin/fly
COPY src/ ./
