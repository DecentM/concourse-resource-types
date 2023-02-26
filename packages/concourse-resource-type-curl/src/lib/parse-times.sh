#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

times=$(cat .curl/times)

user_shell=$(printf '%s\n' "$times" | head -n1 | cut -d ' ' -f1)
system_shell=$(printf '%s\n' "$times" | head -n1 | cut -d ' ' -f2)
user_child=$(printf '%s\n' "$times" | tail -n1 | cut -d ' ' -f1)
system_child=$(printf '%s\n' "$times" | tail -n1 | cut -d ' ' -f2)

rm -f .curl/times
mkdir -p .curl/times

printf '%s\n' "$user_shell" >.curl/times/user_shell
printf '%s\n' "$system_shell" >.curl/times/system_shell
printf '%s\n' "$user_child" >.curl/times/user_child
printf '%s\n' "$system_child" >.curl/times/system_child
