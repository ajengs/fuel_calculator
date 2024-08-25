# Fuel Calculator

This application aims to calculate fuel to launch from one planet of the solar system and land on another planet of the solar system, depending on the flight route

## Usage
### As a Library
You can use FuelCalculator in your Elixir code as follows:
  ```elixir
  iex> FuelCalculator.calculate_total_fuel(28801, [{:land, "earth"}])
  13447
  iex> FuelCalculator.calculate_total_fuel(28801, [{:launch, "earth"}, {:land, "moon"}, {:launch, "moon"}, {:land, "earth"}])
  51898
  ```

### Interactive Command Line Interface

FuelCalculator comes with an interactive command-line interface for easy calculations. To use it:

1. Navigate to the project directory.
2. Run the script:
   ```bash
   elixir fuel_calculator_app.exs
   ```

3. Follow the prompts to enter the mass of the ship and the route.

  Example interaction:
  ```bash
  Enter the mass of the ship:
  28801
  Enter the route (e.g., 'land earth, launch moon, land earth'):
  Available actions: land, launch
  Available planets: earth, moon, mars
  launch earth, land moon, launch moon, land earth
  Total fuel needed: 51898
  ```

## Development

To run tests:
```bash
mix test
```
