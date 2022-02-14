defmodule Calculator do
  def start do
    spawn(fn -> loop(0) end)
  end

  def value(server_pid) do
    send(server_pid, {:value, self()})

    receive do
      {:response, value} -> value
    end
  end

  def add(server_pid, value) do
    send(server_pid, {:add, value})
  end

  def sub(server_pid, value) do
    send(server_pid, {:sub, value})
  end

  def mul(server_pid, value) do
    send(server_pid, {:mul, value})
  end

  def div(server_pid, value) do
    send(server_pid, {:div, value})
  end

  # keep the mutable state using the private loop function
  defp loop(current_value) do
    new_value =
      receive do
        {:value, caller} ->
          send(caller, {:response, current_value})
          current_value

        {:add, value} ->
          current_value + value

        {:sub, value} ->
          current_value - value

        {:mul, value} ->
          current_value * value

        {:div, value} ->
          current_value / value

        invalid_request ->
          IO.puts("invalid request #{inspect(invalid_request)}")
          current_value
      end

    loop(new_value)
  end
end

calculator_pid = Calculator.start()
Calculator.value(calculator_pid)
Calculator.add(calculator_pid, 10)
Calculator.value(calculator_pid)
Calculator.mul(calculator_pid, 100)
Calculator.value(calculator_pid)
