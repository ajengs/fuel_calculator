defmodule FuelCalculator.TaskWorker do
  use GenServer
  require IEx
  alias FuelCalculator.Worker

  @max_retries 3
  # milliseconds
  @retry_delay 1000

  # Client API
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def perform_task(mass, path) do
    GenServer.call(__MODULE__, {:perform_task, mass, path})
  end

  def get_tasks do
    GenServer.call(__MODULE__, :get_tasks)
  end

  # Server Callbacks
  def init(_) do
    {:ok, []}
  end

  def handle_call({:perform_task, mass, path}, _from, state) do
    case perform_with_retry(mass, path, @max_retries) do
      {:ok, total_fuel} -> {:reply, total_fuel, [{mass, path, total_fuel} | state]}
      :error -> {:reply, :error, state}
    end
  end

  def handle_call(:get_tasks, _from, state) do
    {:reply, Enum.reverse(state), state}
  end

  defp perform_with_retry(_, _, 0) do
    IO.puts("Task failed after retries.")
    :error
  end

  defp perform_with_retry(mass, path, retries_left) do
    case Worker.perform(mass, path) do
      {:error, reason} ->
        IO.puts("Task failed with reason: #{inspect(reason)}. Retrying...")
        :timer.sleep(@retry_delay)
        perform_with_retry(mass, path, retries_left - 1)

      total_fuel ->
        {:ok, total_fuel}
    end
  end
end
