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

touch .curl/output
curl "$url" \
  --cookie-jar .curl/cookie-jar \
  --etag-save .curl/etag-save \
  --dump-header .curl/dump-header \
  --output .curl/output \
  --fail-with-body \
  "${arguments[@]}"

curl_exit=$?

if [ $curl_exit -eq 26 ]; then
  exit 26
fi

set -e

times >.curl/times

"$(dirname "$0")"/parse-response-code.sh
"$(dirname "$0")"/parse-output-size.sh
"$(dirname "$0")"/parse-times.sh
