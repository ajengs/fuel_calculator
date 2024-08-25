# Fuel Calculator

This application aims to calculate fuel to launch from one planet of the solar system and land on another planet of the solar system, depending on the flight route

## Usage
  ```elixir
  iex> FuelCalculator.Server.perform(28801, [{:land, "earth"}])
  13447
  iex> FuelCalculator.Server.perform(28801, [{:launch, "earth"}, {:land, "moon"}, {:launch, "moon"}, {:land, "earth"}])
  51898
  ```

  When the process crashes, the Supervisor will immediately attempt to restart it. If the number of restarts exceeds 3 within any 5-second window, the Supervisor will shut down all its children and then terminate itself.

## Development

To run tests:
```bash
mix test
```
