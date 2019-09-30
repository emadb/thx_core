defmodule ThxCore.MixProject do
  use Mix.Project

  def project do
    [
      app: :thx_core,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      aliases: aliases()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
     test: ["ecto.drop", "ecto.create --quiet", "ecto.migrate", "run priv/repo/seeds.exs", "test"]
    ]
  end
  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :postgrex, :ecto],
      mod: {ThxCore.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:postgrex, "~> 0.14.1"},
      {:ecto_sql, "~> 3.0"},
      {:mox, "~> 0.5.0"},
      {:elixir_ale, "~> 1.2"},
      {:cowboy, "~> 2.6"},
      {:plug, "~> 1.8"},
      {:poison, "~> 4.0"},
      {:plug_cowboy, "~> 2.1"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
