defmodule FuelCalculatorTest do
  use ExUnit.Case

  describe "Supervisor" do
    test "supervises worker" do
      # stop the application, restart the application
      :ok = Application.stop(:fuel_calculator)
      {:ok, _} = Application.ensure_all_started(:fuel_calculator)

      # the supervisor should have a child
      children = Supervisor.which_children(Supervisor)
      assert Enum.any?(children, fn {module, _, _, _} -> module == FuelCalculator.Server end)

      # the supervisor should restart the worker if it dies
      pid = Process.whereis(FuelCalculator.Server)
      assert is_pid(pid)

      Process.exit(pid, :kill)
      :timer.sleep(10)

      new_pid = Process.whereis(FuelCalculator.Server)
      assert is_pid(new_pid)
      assert new_pid != pid
    end
  end
end
