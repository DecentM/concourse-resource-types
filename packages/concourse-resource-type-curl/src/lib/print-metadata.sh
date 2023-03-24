#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

hash=$(sha256sum .curl/output | cut -d ' ' -f1)
etag_save=$(tr -d '"' <.curl/etag-save)
response_code=$(head -n1 <.curl/response-code)
output_size_bytes=$(head -n1 <.curl/output-size-bytes)

jq \
  --arg hash "$hash" \
  --arg etag_save "$etag_save" \
  --arg response_code "$response_code" \
  --arg output_size_bytes "$output_size_bytes" \
  --arg user_shell "$(cat .curl/times/user_shell)" \
  --arg system_shell "$(cat .curl/times/system_shell)" \
  --arg user_child "$(cat .curl/times/user_child)" \
  --arg system_child "$(cat .curl/times/system_child)" \
  -n '{
  version: { hash: $hash },
  metadata: [
    { name: "hash", value: $hash },
    { name: "etag-save", value: $etag_save },
    { name: "response-code", value: $response_code },
    { name: "output-size-bytes", value: $output_size_bytes },
    { name: "user_shell", value: $user_shell },
    { name: "system_shell", value: $system_shell },
    { name: "user_child", value: $user_child },
    { name: "system_child", value: $system_child }
  ]
}'
