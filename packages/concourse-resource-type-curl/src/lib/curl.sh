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

set +e

curl "$url" \
  --cookie-jar .curl/cookie-jar \
  --etag-save .curl/etag-save \
  --dump-header .curl/dump-header \
  --output .curl/output \
  --fail-with-body \
  "${arguments[@]}"

set -e

times >.curl/times

"$(dirname "$0")"/parse-response-code.sh
"$(dirname "$0")"/parse-output-size.sh
"$(dirname "$0")"/parse-times.sh
