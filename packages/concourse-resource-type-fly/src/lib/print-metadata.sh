#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

hash=$(sha256sum .fly/output | cut -d ' ' -f1)

jq \
  --arg hash "$hash" \
  --arg user_shell "$(cat .fly/times/user_shell)" \
  --arg system_shell "$(cat .fly/times/system_shell)" \
  --arg user_child "$(cat .fly/times/user_child)" \
  --arg system_child "$(cat .fly/times/system_child)" \
  -n '{
  version: { hash: $hash },
  metadata: [
    { name: "hash", value: $hash },
    { name: "user_shell", value: $user_shell },
    { name: "system_shell", value: $system_shell },
    { name: "user_child", value: $user_child },
    { name: "system_child", value: $system_child }
  ]
}'
