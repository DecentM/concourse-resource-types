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

readarray -t arguments < <(printf '%s\n' "$1" | jq -rc '.[]')

fly "${arguments[@]}" >.fly/output

times >.fly/times

"$(dirname "$0")"/parse-times.sh
