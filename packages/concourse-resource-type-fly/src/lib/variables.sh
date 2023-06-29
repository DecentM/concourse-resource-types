#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

payload=$(cat)

get_payload() {
  if [ $# -eq 1 ]; then
    jq -r "$1" <<<"$payload" | sed 's/\\n//g'
  else
    jq -r "$1 // \"$2\"" <<<"$payload" | sed 's/\\n//g'
  fi
}

set +u

variable=$1

case $variable in
"skip")
  get_payload ".params.skip"
  ;;
"check_arguments")
  check_arguments=$(get_payload ".source.check_arguments" "[]")
  source_arguments=$(get_payload ".source.arguments" "[]")

  printf '%s\n' "[$check_arguments, $source_arguments]" | jq -r "flatten(1)"
  ;;
"arguments")
  source_arguments=$(get_payload ".source.arguments" "[]")
  params_arguments=$(get_payload ".params.arguments" "[]")

  printf '%s\n' "[$source_arguments, $params_arguments]" | jq -r "flatten(1)"
  ;;
*)
  printf 'Supported variables: "arguments", "check_arguments", "skip".\n\nUsage: variables.sh <variable>\n'
  exit 1
  ;;
esac
