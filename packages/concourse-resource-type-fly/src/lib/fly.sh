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

readarray -t arguments < <(printf '%s\n' "$4" | jq -rc '.[]')

fly -t default -c "$ATC_EXTERNAL_URL" login --username="$username" --password="$password" --team-name="$team"

fly -t default "${arguments[@]}" >.fly/output

times >.fly/times

"$(dirname "$0")"/parse-times.sh
