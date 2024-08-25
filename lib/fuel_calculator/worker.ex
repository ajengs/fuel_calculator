defmodule FuelCalculator.Worker do
  @moduledoc """
  Documentation for `FuelCalculator.Worker`.
  """

  @doc """
  Calculate the fuel needed to land on Earth.

  ## Examples

      iex> FuelCalculator.Worker.perform(28801, [{:land, "earth"}])
      13447

      iex> FuelCalculator.Worker.perform(28801, [{:launch, "earth"}, {:land, "moon"}, {:launch, "moon"}, {:land, "earth"}])
      51898

  """
  @gravity %{
    "earth" => 9.807,
    "moon" => 1.62,
    "mars" => 3.711
  }

  def perform(mass, path) do
    Enum.reverse(path)
    |> calculate_per_path(mass, 0)
  end

  defp calculate_per_path([], _mass, total_fuel_needed), do: total_fuel_needed

  defp calculate_per_path([{action, planet} | tail], mass, total_fuel_needed) do
    case Map.fetch(@gravity, planet) do
      {:ok, gravity} ->
        accumulated_fuel = accumulate_fuel_per_path(action, gravity, mass, 0)
        calculate_per_path(tail, mass + accumulated_fuel, total_fuel_needed + accumulated_fuel)

      :error ->
        {:error, "Error: Unknown gravity for planet #{planet}"}
    end
  end

  defp accumulate_fuel_per_path(_action, _gravity, mass, fuel_per_path) when mass <= 0,
    do: fuel_per_path

  defp accumulate_fuel_per_path(action, gravity, mass, fuel_per_path) do
    additional_fuel = calculate_fuel(action, mass, gravity)
    accumulate_fuel_per_path(action, gravity, additional_fuel, fuel_per_path + additional_fuel)
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
