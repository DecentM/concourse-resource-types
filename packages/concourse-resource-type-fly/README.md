# Fly Resource

Tracks changes in `fly` commands targeting the current Concourse URL

- [Fly Resource](#fly-resource)
  - [Source Configuration](#source-configuration)
  - [Behaviour](#behaviour)
    - [`check`: Check the hash of the returned response](#check-check-the-hash-of-the-returned-response)
    - [`in`: Run the command, and return its response](#in-run-the-command-and-return-its-response)
      - [Parameters (get)](#parameters-get)
      - [Additional files populated](#additional-files-populated)
    - [`out`: Hit the URL](#out-hit-the-url)
      - [Parameters (put)](#parameters-put)

## Source Configuration

- `username`: *Required.* A user's username who has access to the `main` team or
  the team the resource wants to reference

- `password`: *Required.* A user's password who has access to the `main` team or
  the team the resource wants to reference

- `team`: *Optional.* The team associated with the pipeline this resource is in.
  Default: `main`

- `arguments`: *Optional.* An array of strings to pass to `fly`. For the best
  reqults, wrap each in double quotes. Do not specify `-t`, as it's always the
  local Concourse instance. Default: `[]`
  Example:

  ```yaml
  arguments:
    - "--verbose"
    - "workers"
  ```

- `check_arguments`: *Optional.* Same as `arguments`, but this will only be
  passed during the `check` behaviour. Default: `[]`

## Behaviour

### `check`: Check the hash of the returned response

The command is executed with the `check_arguments` and `arguments`, and the hash of the response will be returned as the
current version. This is a hash of the stdout output of your command.

### `in`: Run the command, and return its response

The command is executed with `arguments` and `params.arguments`, and the
response output is saved to `<resource name>/output` [with various other metadata](#additional-files-populated).

#### Parameters (get)

- `sync`: *Optional.* If true, `fly sync` will be ran before the specified
  command with arguments. Default: `<empty>`

- `skip`: *Optional* If true, the command will not be run. Default: `<empty>`

- `arguments`: *Optional.* Same as source arguments, the two will be merged
  together. Default: `[]`
  Example:

  ```yaml
  arguments:
    - "--verbose"
    - "workers"
  ```

#### Additional files populated

- `<resource name>/output`: The entire body of the response from the server

- `<resource name>/output-size-bytes`: The size of the response body in bytes

- `<resource name>/times`: A directory containing the output of the `times` command. It
  has the following files:
  - `<resource name>/times/system_child`: The top left value
  - `<resource name>/times/system_shell`: The top right value
  - `<resource name>/times/user_child`: The bottom left value
  - `<resource name>/times/user_shell`: The bottom right value

### `out`: Hit the URL

The command is the same as `in`. It's executed with `arguments` and `params.arguments`, and the
response output is saved to `<resource name>/output` with the same metadata as `in`.

#### Parameters (put)

(same as `get`)
