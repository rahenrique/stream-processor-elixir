defmodule LogStream.MixProject do
  use Mix.Project

  def project do
    [
      app: :log_stream,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :kaffe],
      # tell the Application module to start a supervision tree:
      mod: {LogStream.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:kaffe, "~> 1.9"},
      {:httpoison, "~> 2.0"},
      {:poison, "~> 5.0"},
      {:json, "~> 1.4"},
      {:geolix, "~> 2.0"},
      {:geolix_adapter_mmdb2, "~> 0.6.0"}
    ]
  end
end
