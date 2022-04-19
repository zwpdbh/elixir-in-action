defmodule SonarPilot do
  use GenServer

  @me SonarPilot
  
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: @me)
  end

  def move(command) when is_binary(command) do
    # parse command to message
    with [m, n] <- String.split(command, " "),
         {num, ""} <- Integer.parse(n) do
      case m do
        "forward" -> GenServer.cast(@me, {:forward, num})
        "down" -> GenServer.cast(@me, {:down, num})
        "up" -> GenServer.cast(@me, {:up, num})
        _ -> IO.puts("ill commands")
      end
    else
      error -> IO.inspect(error)
    end
  end

  def get_position() do
    GenServer.call(@me, :get_position)
  end

  # callbacks 
  def init(_) do
    {:ok, %{horizontal: 0, depth: 0}}
  end

  def handle_cast({:forward, n}, %{horizontal: x, depth: y}) do
    {:noreply, %{horizontal: x + n, depth: y}}
  end

  def handle_cast({:down, n}, %{horizontal: x, depth: y}) do
    {:noreply, %{horizontal: x, depth: y + n}}
  end

  def handle_cast({:up, n}, %{horizontal: x, depth: y}) do
    {:noreply, %{horizontal: x, depth: y - n}}
  end

  def handle_call(:get_position, _from,  %{horizontal: x, depth: y}) do
    {:reply, x * y, %{horizontal: x, depth: y}}
  end
end
