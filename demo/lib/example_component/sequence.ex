# Our API module, is the public face of our component.
defmodule Sequence do
  @server Sequence.Server
  def start_link(_) do
    GenServer.start_link(@server, Sequence.Stash.get(), name: @server)
  end

  def next_number do
    GenServer.call(@server, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(@server, {:increment_number, delta})
  end
end
