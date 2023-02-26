#!/bin/bash

set -e

if [ -n "${DEBUG}" ]; then
  set -x
fi

set -u

code=$1
range_min=$2
range_max=$3

if [ "$code" -gt "$range_max" ] || [ "$code" -lt "$range_min" ]; then
  printf '%s\n' "ERROR: Response code \"$code\" is outside of acceptable range ($range_min - $range_max)" 1>&2
  exit 1
fi
