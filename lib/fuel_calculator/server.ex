defmodule FuelCalculator.Server do
  use GenServer
  alias FuelCalculator.Worker

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def perform(mass, path) do
    GenServer.call(__MODULE__, {:perform, mass, path})
  end

  def get_tasks do
    GenServer.call(__MODULE__, :get_tasks)
  end

  def init(_) do
    {:ok, []}
  end

  def handle_call({:perform, mass, path}, _from, state) do
    case Worker.perform(mass, path) do
      {:error, _} = error -> {:reply, error, state}
      total_fuel -> {:reply, total_fuel, [{mass, path, total_fuel} | state]}
    end
  end

  def handle_call(:get_tasks, _from, state) do
    {:reply, Enum.reverse(state), state}
  end
end
