defmodule FuelCalculatorTest do
  use ExUnit.Case
  doctest FuelCalculator

  test "calculate the fuel needed to land on Earth" do
    assert FuelCalculator.calculate_total_fuel(28801, [{:land, "earth"}]) == 13447
  end

  test "calculate the fuel needed to launch from Moon" do
    assert FuelCalculator.calculate_total_fuel(28801 + 13447, [{:launch, "moon"}]) == 3001
  end

  test "calculate the fuel needed to land on Moon" do
    assert FuelCalculator.calculate_total_fuel(28801 + 13447 + 3001, [{:land, "moon"}]) == 2462
  end

  test "calculate the fuel needed to launch from Earth" do
    assert FuelCalculator.calculate_total_fuel(28801 + 13447 + 3001 + 2462, [{:launch, "earth"}]) ==
             32988
  end

  test "calculate the fuel needed for journey from Moon to Earth" do
    assert FuelCalculator.calculate_total_fuel(28801, [
             {:launch, "moon"},
             {:land, "earth"}
           ]) == 16448
  end

  test "calculate the fuel needed for journey from Earth to Moon and back" do
    assert FuelCalculator.calculate_total_fuel(28801, [
             {:launch, "earth"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "earth"}
           ]) == 51898
  end

  test "calculate the fuel needed for journey from Earth to Mars and back" do
    assert FuelCalculator.calculate_total_fuel(14606, [
             {:launch, "earth"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "earth"}
           ]) == 33388
  end

  test "calculate the fuel needed for journey from Earth to Moon to Mars and back" do
    assert FuelCalculator.calculate_total_fuel(75432, [
             {:launch, "earth"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "earth"}
           ]) == 212_161
  end
end
