# Keenex

[Documentation](http://hexdocs.pm/keenex)

Keenex provides an Elixir interface to the Keen.io HTTP API.

## Usage

Add it to your applications and dependencies in `mix.exs`:

    def application do
      [applications: [:keenex]]
    end

    def deps do
      [{:keenex, "~> 1.0"}]
    end

Configure it in `config.exs`:

    config :keenex,
      project_id: "xxxxx",  # defaults to System.get_env("KEEN_PROJECT_ID")
      read_key:   "xxxxx",  # defaults to System.get_env("KEEN_READ_KEY")
      write_key:  "xxxxx",  # defaults to System.get_env("KEEN_WRITE_KEY")
      httpoison_opts: [timeout: 5000]  # defaults to []

And then call functions like:

    {status, response} = Keenex.add_event("dinner.tacos", %{test: "tacos"})

`status` is either `:ok` or `:error`.

`response` is a Map converted from the JSON response from Keen.
Information about the contents of the response can be found
[here](https://keen.io/docs/api/).

