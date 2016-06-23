defmodule Keenex.Mixfile do
  use Mix.Project

  def project do
    [app: :keenex,
     version: "0.4.0",
     elixir: "~> 1.0",
     deps: deps,
     description: "Keen.io API Client",
     package: package,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test],
     source_url: "https://github.com/bryanjos/keenex" ]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [:httpoison, :logger, :poison],
      mod: {Keenex, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8"},
      {:poison, "~> 1.0 or ~> 2.0"},
      {:earmark, "~> 0.2", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:exvcr, "~> 0.7", only: [:dev, :test]},
      {:excoveralls, "~> 0.4", only: [:dev, :test]},
      {:credo, "~> 0.2.0", only: [:dev, :test]}
    ]
  end

  defp package do
    [ # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
      maintainers: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{ "GitHub" => "https://github.com/bryanjos/keenex" }
    ]
  end
end
