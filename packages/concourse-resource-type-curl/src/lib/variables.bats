#!/usr/bin/env bats

setup() {
  load '/usr/lib/bats-support/load'
  load '/usr/lib/bats-assert/load'

  # get the containing directory of this file
  # use $BATS_TEST_FILENAME instead of ${BASH_SOURCE[0]} or $0,
  # as those will point to the bats executable's location or the preprocessed file respectively
  DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")" >/dev/null 2>&1 && pwd)"
  # make executables in src/ visible to PATH
  PATH="$DIR/:$PATH"
}

data_with_params_url='{"source": {"url": "source-url"}, "params": {"url": "params-url"}}'
data_without_params_url='{"source": {"url": "source-url"}, "params": {}}'

@test "gets params URL when it exists" {
  # echo $(dirname)
  run variables.sh url <<<"$data_with_params_url"

  assert_output 'params-url'
}

@test "gets source URL when params url doesn't exist" {
  # echo $(dirname)
  run variables.sh url <<<"$data_without_params_url"

  assert_output 'source-url'
}
