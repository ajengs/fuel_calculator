defmodule FuelCalculator do
  @moduledoc """
  Documentation for `FuelCalculator`.
  """

  @doc """
  Calculate the fuel needed to land on Earth.

  ## Examples

      iex> FuelCalculator.calculate_total_fuel(28801, [{:land, "earth"}])
      13447

      iex> FuelCalculator.calculate_total_fuel(28801, [{:launch, "earth"}, {:land, "moon"}, {:launch, "moon"}, {:land, "earth"}])
      51898

  """
  @gravity %{
    "earth" => 9.807,
    "moon" => 1.62,
    "mars" => 3.711
  }

  def calculate_total_fuel(mass, path) do
    Enum.reverse(path)
    |> Enum.reduce(0, fn step, total_fuel_needed ->
      calculate_needed_fuel(step, mass + total_fuel_needed, total_fuel_needed)
    end)
  end

  defp calculate_needed_fuel(_, mass, total_fuel_needed) when mass <= 0, do: total_fuel_needed

  defp calculate_needed_fuel({action, planet} = step, mass, total_fuel_needed) do
    additional_fuel = calculate_fuel(action, mass, Map.fetch!(@gravity, planet))
    calculate_needed_fuel(step, additional_fuel, total_fuel_needed + additional_fuel)
  end

  defp calculate_fuel(:launch, mass, gravity) do
    (mass * gravity * 0.042 - 33)
    |> floor()
    |> max(0)
  end

  defp calculate_fuel(:land, mass, gravity) do
    (mass * gravity * 0.033 - 42)
    |> floor()
    |> max(0)
  end
end
