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

jq -n "{
  version: { hash: \"$hash\" },
  metadata: [
    { name: \"hash\", value: \"$hash\" },
    { name: \"etag-save\", value: \"$etag_save\" },
    { name: \"response-code\", value: \"$response_code\" },
    { name: \"output-size-bytes\", value: \"$output_size_bytes\" },
    { name: \"user_shell\", value: \"$(cat .curl/times/user_shell)\" },
    { name: \"system_shell\", value: \"$(cat .curl/times/system_shell)\" },
    { name: \"user_child\", value: \"$(cat .curl/times/user_child)\" },
    { name: \"system_child\", value: \"$(cat .curl/times/system_child)\" }
  ]
}"
