Keenex
======

```elixir
{:keenex, "~> 1.0"}
```

[Documentation](http://hexdocs.pm/keenex)

Usage:

looks for application variables in the `:keenex` app named `:project_id`, `:write_key`, `:read_key`
or if any of those aren't available, it looks for environment variables named `KEEN_PROJECT_ID`, `KEEN_WRITE_KEY`, `KEEN_READ_KEY`

Add it to your applications:

```elixir
  def application do
    [applications: [:keenex]]
  end
```

then call functions

```elixir
{status, response} = Keenex.add_event("dinner.tacos", %{test: "tacos"})
```

status is either `:ok` or `:error`

response is a Map converted from the json response from Keen.

For info about the content of the results, check out the [Keen API reference](https://keen.io/docs/api/)
