#!/bin/sh

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

payload=$(cat)

get_payload() {
  if [ $# -eq 1 ]; then
    printf '%s\n' "$payload" | jq -r ".$1"
  else
    printf '%s\n' "$payload" | jq -r ".$1 // \"$2\""
  fi
}

variable=$1

case $variable in
"url")
  get_payload "source.url"
  ;;
"source.arguments")
  get_payload "source.arguments" "[]" | jq -r 'map("\"" + . + "\"") | join(" ")'
  ;;
"params.arguments")
  get_payload "params.arguments" "[]" | jq -r 'map("\"" + . + "\"") | join(" ")'
  ;;
*)
  printf 'Supported variables: "url", "arguments".\n\nUsage: ./variables.sh <variable>\n'
  exit 1
  ;;
esac
