#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

headers=$(cat .curl/dump-header)

(grep "^HTTP/" | tail -n1 | cut -d ' ' -f2) <<<"$headers" >.curl/response-code
