defmodule FuelCalculator.Supervisor do
  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      {FuelCalculator.Server, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: FuelCalculator.Supervisor,
      max_restarts: 3,
      max_seconds: 5
    ]

    Supervisor.init(children, opts)
  end
end
