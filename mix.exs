defmodule InteroperabilityTest.MixProject do
  # alias Hex.Application
  use Mix.Project

  def project do
    [
      app: :interoperability_test,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      # mod: {InteroperabilityTest.MyTcpApplication,[]}
      mod: {InteroperabilityTest.MyHttpApplication,[]}
      # mod: {Benchmark.SpeedElixirApplication,[]} # benchmark test di interoperabilità
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:erlport, "~> 0.11.0"},
      {:benchee, "~> 1.0", only: :dev},
      {:benchee_csv, "~> 1.0", only: :dev},
      {:poolboy, "~> 1.5"},
      {:plug_cowboy, "~> 2.0"},
      {:httpoison, "~> 2.0"},
      {:poison, "~> 5.0"} # for json
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
