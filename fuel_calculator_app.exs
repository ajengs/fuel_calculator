Code.require_file("lib/fuel_calculator.ex")

defmodule FuelCalculatorApp do
  def run do
    mass = get_mass()
    route = get_route()

    result = FuelCalculator.calculate_total_fuel(mass, route)
    IO.puts("\nTotal fuel needed: #{result}")
  end

  defp get_mass do
    IO.puts("Enter the mass of the ship:")
    String.trim(IO.gets("")) |> String.to_integer()
  end

  defp get_route do
    IO.puts("\nEnter the route (e.g., 'land earth, launch moon, land earth'):")
    IO.puts("Available actions: land, launch")
    IO.puts("Available planets: earth, moon, mars")

    String.trim(IO.gets(""))
    |> String.split(",")
    |> Enum.map(&parse_step/1)
  end

  defp parse_step(step) do
    [action, planet] = String.split(String.trim(step))
    {String.to_atom(action), planet}
  end
end

FuelCalculatorApp.run()
