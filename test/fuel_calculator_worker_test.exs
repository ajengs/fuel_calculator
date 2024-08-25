defmodule FuelCalculator.WorkerTest do
  use ExUnit.Case
  doctest FuelCalculator.Worker
  alias FuelCalculator.Worker

  test "calculate the fuel needed to land on Earth" do
    assert Worker.perform(28801, [{:land, "earth"}]) == 13447
  end

  test "calculate the fuel needed to launch from Moon" do
    assert Worker.perform(28801 + 13447, [{:launch, "moon"}]) == 3001
  end

  test "calculate the fuel needed to land on Moon" do
    assert Worker.perform(28801 + 13447 + 3001, [{:land, "moon"}]) == 2462
  end

  test "calculate the fuel needed to launch from Earth" do
    assert Worker.perform(28801 + 13447 + 3001 + 2462, [
             {:launch, "earth"}
           ]) == 32988
  end

  test "calculate the fuel needed for journey from Moon to Earth" do
    assert Worker.perform(28801, [
             {:launch, "moon"},
             {:land, "earth"}
           ]) == 16448
  end

  test "calculate the fuel needed for journey to Moon and back" do
    assert Worker.perform(28801, [
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "earth"}
           ]) == 18910
  end

  test "calculate the fuel needed for journey from Earth to Moon and back" do
    assert Worker.perform(28801, [
             {:launch, "earth"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "earth"}
           ]) == 51898
  end

  test "calculate the fuel needed for journey from Earth to Mars and back" do
    assert Worker.perform(14606, [
             {:launch, "earth"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "earth"}
           ]) == 33388
  end

  test "calculate the fuel needed for journey from Earth to Moon to Mars and back" do
    assert Worker.perform(75432, [
             {:launch, "earth"},
             {:land, "moon"},
             {:launch, "moon"},
             {:land, "mars"},
             {:launch, "mars"},
             {:land, "earth"}
           ]) == 212_161
  end

  test "return error for journey with unknown planet" do
    assert Worker.perform(75432, [{:launch, "earth"}, {:land, "pluto"}, {:launch, "moon"}]) ==
             {:error, "Error: Unknown gravity for planet pluto"}
  end
end
