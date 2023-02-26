#!/bin/sh

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
arguments=$2

trap "times > .curl/times" EXIT

printf '%s\n' "$arguments" | xargs curl "$url" \
  --cookie-jar .curl/cookie-jar \
  --etag-save .curl/etag-save \
  --dump-header .curl/dump-header \
  --output .curl/output \
  --fail-with-body \
  --location
