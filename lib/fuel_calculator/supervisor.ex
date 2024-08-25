defmodule FuelCalculator.Supervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      {FuelCalculator.TaskWorker, []}
    ]

    opts = [strategy: :one_for_one, name: FuelCalculator.Supervisor]
    Supervisor.init(children, opts)
  end
end
