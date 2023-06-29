#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

times=$(cat .fly/times)

user_shell=$(printf '%s\n' "$times" | head -n1 | cut -d ' ' -f1)
system_shell=$(printf '%s\n' "$times" | head -n1 | cut -d ' ' -f2)
user_child=$(printf '%s\n' "$times" | tail -n1 | cut -d ' ' -f1)
system_child=$(printf '%s\n' "$times" | tail -n1 | cut -d ' ' -f2)

rm -f .fly/times
mkdir -p .fly/times

printf '%s\n' "$user_shell" >.fly/times/user_shell
printf '%s\n' "$system_shell" >.fly/times/system_shell
printf '%s\n' "$user_child" >.fly/times/user_child
printf '%s\n' "$system_child" >.fly/times/system_child
