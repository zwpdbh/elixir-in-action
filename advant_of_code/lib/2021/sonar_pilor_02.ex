defmodule SonarPilot02 do
  use GenServer
  @me SonarPilot02

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: @me)
  end

  def move(command) do
    with [message, value_str] <- String.split(command, " "),
         {value, _} <- Integer.parse(value_str) do
      case message do
        "down" -> GenServer.cast(@me, {:down, value})
        "up" -> GenServer.cast(@me, {:up, value})
        "forward" -> GenServer.cast(@me, {:forward, value})
      end
    else
      error ->
        IO.inspect(error)
    end
  end

  def get_position do
    GenServer.call(@me, :get_position)
  end

  def init(_) do
    {:ok, %{horizontal: 0, depth: 0, aim: 0}}
  end

  def handle_cast({:down, n}, %{horizontal: x, depth: y, aim: z}) do
    {:noreply, %{horizontal: x, depth: y, aim: z + n}}
  end

  def handle_cast({:up, n}, %{horizontal: x, depth: y, aim: z}) do
    {:noreply, %{horizontal: x, depth: y, aim: z - n}}
  end

  def handle_cast({:forward, n}, %{horizontal: x, depth: y, aim: z}) do
    {:noreply, %{horizontal: x + n, depth: y + z * n, aim: z}}
  end

  def handle_call(:get_position, _from, %{horizontal: x, depth: y, aim: z}) do
    {:reply, x * y, %{horizontal: x, depth: y, aim: z}}
  end
end
