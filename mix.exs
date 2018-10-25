defmodule Keenex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :keenex,
      version: "1.0.1",
      elixir: "~> 1.0",
      deps: deps(),
      description: "Keen.io API Client",
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      source_url: "https://github.com/bryanjos/keenex"
    ]
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
      {:httpoison, "~> 1.0"},
      {:poison, "~> 4.0"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:exvcr, "~> 0.10", only: [:dev, :test]},
      {:excoveralls, "~> 0.4", only: [:dev, :test]},
      {:credo, "~> 0.10", only: [:dev, :test]}
    ]
  end

  defp package do
    # These are the default files included in the package
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Bryan Joseph"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/bryanjos/keenex"}
    ]
  end
end
