defmodule FuelCalculatorServerTest do
  use ExUnit.Case

  describe "Server" do
    test "server started and execute calls" do
      {:ok, _} = Application.ensure_all_started(:fuel_calculator)

      assert FuelCalculator.Server.get_tasks() == []
      assert FuelCalculator.Server.perform(0, []) == 0
      assert FuelCalculator.Server.get_tasks() == [{0, [], 0}]

      assert FuelCalculator.Server.perform(0, [{:launch, "unknown"}]) ==
               {:error, "Error: Unknown gravity for planet unknown"}

      assert FuelCalculator.Server.get_tasks() == [{0, [], 0}]
    end
  end
end
