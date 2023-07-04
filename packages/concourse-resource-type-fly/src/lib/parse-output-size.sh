#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

stat -c "%s" .fly/output >.fly/output-size-bytes
