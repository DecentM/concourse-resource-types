# Curl Resource

Tracks changes in web responses.

- [Curl Resource](#curl-resource)
  - [Source Configuration](#source-configuration)
  - [Behaviour](#behaviour)
    - [`check`: Check the hash of the returned response](#check-check-the-hash-of-the-returned-response)
    - [`in`: Hit the URL and return its response](#in-hit-the-url-and-return-its-response)
      - [Parameters (get)](#parameters-get)
      - [Additional files populated](#additional-files-populated)
    - [`out`: Hit the URL](#out-hit-the-url)
      - [Parameters (put)](#parameters-put)

## Source Configuration

- `url`: *Required.* The address this resource will interact with. Any URL
  accepted by `curl` is allowed.

- `arguments`: *Optional.* An array of strings to pass to `curl`. For the best
  reqults, wrap each in double quotes.
  Example:

  ```yaml
  arguments:
    - "-A"
    - "My-User-Agent"
  ```

- `check_arguments`: *Optional.* Same as `arguments`, but this will only be
  passed during the `check` behaviour.

- `response_code`: *Optional.* An object that defines a range of response codes.
  If the response code of the URL is within this range, the request will be
  considered successful. It has the following properties:
  - `min`: *Optional. Default: 200.* The lower bound of the acceptable range
  - `max`: *Optional. Default: 299.* The upper bound of the acceptable range

## Behaviour

### `check`: Check the hash of the returned response

The command is executed with the `check_arguments` and `arguments`, and the hash of the response will be returned as the
current version. This hash ignores headers and only uses the body of the
response.

### `in`: Hit the URL and return its response

The command is executed with `arguments` and `params.arguments`, and the
response output is saved to `<resource name>/output` [with various other metadata](#additional-files-populated).

#### Parameters (get)

- `url`: *Optional.* The address this resource will interact with. Any URL
  accepted by `curl` is allowed, and if not specified the URL from the source
  configuration will be used.

- `skip`: *Optional* If `true`, no request will be made.

- `arguments`: *Optional.* An additional array of strings that serve as
  arguments. This array will be merged with the arguments from the source
  configuration, `check_arguments` is ignored.

#### Additional files populated

- `<resource name>/response-code`: The response code of the last request after redirects
  (add `-L` to follow to the end)

- `<resource name>/output`: The entire body of the response from the server

- `<resource name>/output-size-bytes`: The size of the response body in bytes

- `<resource name>/cookie-jar`: Output of the --cookie-jar argument from `curl`

- `<resource name>/etag-save`: Output of the --etag-save argument from `curl`

- `<resource name>/dump-header`: Output of the --dump-header argument from `curl`

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

------------

> ### A note about JSON
>
> This resource supports JSON input embedded into the configuration as YAML
> objects.
>
> Example:
>
> ```yml
> arguments:
>   - "--json"
>   - content: Hello, world!
>     count: 2
> ```
>
> When expanded, curl will receive the following arguments:
>
> `curl --json '{"content": "Hello, world!", "count": 2}'`
