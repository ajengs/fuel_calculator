defmodule FuelCalculator.MixProject do
  use Mix.Project

  def project do
    [
      app: :fuel_calculator,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {FuelCalculator, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    []
  end

  defp aliases do
    [
      test: ["format", "test"]
    ]
  end
end
