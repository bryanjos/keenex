Keenex
======

```elixir
{:keenex, "~> 0.3"}
```

[Documentation](http://hexdocs.pm/keenex)

Usage:

looks for application variables in the `:keen` app named `:project_id`, `:write_key`, `:read_key`
or if any of those aren't available, it looks for environment variables named `KEEN_PROJECT_ID`, `KEEN_WRITE_KEY`, `KEEN_READ_KEY`

Add it to your applications:

```elixir
  def application do
    [applications: [:keenex]]
  end
```

Or call start_link directly either using `start_link\0` or `start_link\3` to pass in variables

```elixir
{:ok, keen} = Keenex.start_link

# OR

{:ok, keen} = Keenex.start_link("keen_project_id", "keen_write_key", "keen_read_key")
```


then call functions

```elixir
{status, response} = Keenex.add_event("dinner.tacos", %{test: "tacos"})
```

status is either `:ok` or `:error`

response is a Map converted from the json response from Keen.

For info about the content of the results, check out the [Keen API reference](https://keen.io/docs/api/)
