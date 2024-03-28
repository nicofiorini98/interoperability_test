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
      # mod: {PythonApp.Application,[]} # test chiamata python con erlport e pooling
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:erlport, "~> 0.11.0"},              # communication library for python or ruby
      {:benchee, "~> 1.0", only: :dev},     # benchmark library
      {:benchee_csv, "~> 1.0", only: :dev}, # plug-in for csv output for benchee
      {:poolboy, "~> 1.5"},                 # pooling library
      {:plug_cowboy, "~> 2.0"},             # http server library
      {:httpoison, "~> 2.0"},               # client http library
      {:poison, "~> 5.0"}                   # json library
    ]
  end
end
