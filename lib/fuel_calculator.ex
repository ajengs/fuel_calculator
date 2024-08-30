defmodule FuelCalculator do
  use Application

  def start(_, _) do
    children = [
      {FuelCalculator.Server, []}
    ]

    opts = [
      strategy: :one_for_one,
      name: Supervisor,
      max_restarts: 3,
      max_seconds: 5
    ]

    Supervisor.start_link(children, opts)
  end
end
