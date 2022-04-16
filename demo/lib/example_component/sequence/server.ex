# Our server module handles request from API module and it use logic module's method to process specific message
# The server doesn't contain any business logic
defmodule Sequence.Server do
  use GenServer
  alias Sequence.Impl

  def init(init_number) do
    {:ok, init_number}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, Impl.next(current_number)}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, Impl.increment(current_number, delta)}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}, and I'am happy"}]]
  end
end
