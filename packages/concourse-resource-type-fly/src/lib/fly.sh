#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

if [ -d .fly ]; then
  rm -rf .fly
fi

mkdir -p .fly

username=$1
password=$2
team=$3
sync=$4

readarray -t arguments < <(printf '%s\n' "$5" | jq -rc '.[]')

fly -t default login -c "$ATC_EXTERNAL_URL" \
  --username "$username" \
  --password "$password" \
  --team-name "$team" >/dev/null

if [ "$sync" = "true" ]; then
  fly -t default sync -c "$ATC_EXTERNAL_URL" >/dev/null
fi

eval "fly -t default ${arguments[*]} >.fly/output"

times >.fly/times

"$(dirname "$0")"/parse-output-size.sh
"$(dirname "$0")"/parse-times.sh
