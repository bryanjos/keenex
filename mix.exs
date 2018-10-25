defmodule Keenex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :keenex,
      version: "1.1.0",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      description: "Keen.io API Client",
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      source_url: "https://github.com/bryanjos/keenex"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      extra_applications: [:logger],
      mod: {Keenex, []}
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.0"},
      {:jason, "~> 1.0"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:excoveralls, "~> 0.4", only: [:dev, :test]},
      {:credo, "~> 0.10", only: [:dev, :test]},
      {:bypass, "~> 0.9.0", only: [:test]},
      {:plug_cowboy, "~> 1.0", only: [:test]}
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
