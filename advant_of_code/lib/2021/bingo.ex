defmodule Bingo do
  use GenServer
  @me Bingo
  
  def start_link(boards_input) do
    GenServer.start_link(__MODULE__, boards_input, name: @me)
  end

  def init(boards_input) do
    {:ok, generate_boards(boards_input)}
  end

  # We need to construct multiple boards as our state
  def generate_boards(boards_input) do
    state = %{}
  end
end
