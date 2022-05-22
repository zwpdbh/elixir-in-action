defmodule Bingo do
  use GenServer
  @me Bingo
  
  def start_link(boards_input) do
    GenServer.start_link(__MODULE__, boards_input, name: @me)
  end

  def init(boards_input) do
    boards = generate_boards_from_input(boards_input)
    state = %{}

    {:ok, state}
  end

  def generate_boards_from_input(boards_input) do
    # IO.inspect boards_input
    
    
    boards =  boards_input
    |> Enum.filter(fn x -> length(x) == 5 end)
    |> Enum.with_index
    |> Enum.reduce([], fn {row_input, i}, acc ->
      case rem(i, 5) do
        0 ->
          [[row_input] | acc]
        _ ->
          [x | rest] = acc
          [Enum.concat(x, [row_input]) | rest]
      end
    end)
  end
end
