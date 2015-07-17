defmodule Keenex.Mixfile do
  use Mix.Project

  def project do
    [app: :keenex,
     version: "0.2.0",
     elixir: "~> 1.0",
     deps: deps,
     description: "Keen.io API Client",
     package: package,
     source_url: "https://github.com/bryanjos/keenex" ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:httpotion, :logger, :poison]]
  end

  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse"},
      {:httpotion, "~> 1.0"},
      {:poison, "~> 1.3.1"},
      {:exvcr, "~> 0.4.0", only: :test},
      # {:exvcr, "~> 0.3.5", only: :test},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.6", only: :dev},
      {:dialyze, "~> 0.1.3", only: :dev}
    ]
  end

  defp package do
    [ # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      contributors: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{ "GitHub" => "https://github.com/bryanjos/keenex" }
    ]
  end
end
