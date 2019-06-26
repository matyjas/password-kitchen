defmodule PK.MixProject do
  use Mix.Project

  def project do
    [
      app: :password_kitchen,
      version: "0.2.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {PK.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.9.1", only: [:dev]},
      {:dialyxir, "~> 1.0.0-rc.2", only: [:dev], runtime: false},
      {:jason, "~> 1.1"},
      {:httpotion, "~> 3.1.0"},
      {:mox, "~> 0.3", only: :test},
      {:plug_cowboy, "~> 2.0"}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end

