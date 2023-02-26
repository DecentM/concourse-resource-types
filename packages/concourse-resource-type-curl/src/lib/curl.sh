#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

if [ -d .curl ]; then
  rm -rf .curl
fi

mkdir -p .curl

url=$1
readarray -t arguments < <(printf '%s\n' "$2" | jq -rc '.[]')

trap "times > .curl/times" EXIT

curl "$url" --cookie-jar .curl/cookie-jar --etag-save .curl/etag-save --dump-header .curl/dump-header --output .curl/output --fail-with-body --location "${arguments[@]}"
