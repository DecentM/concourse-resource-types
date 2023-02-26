#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

stat -c "%s" .curl/output >.curl/output-size-bytes
