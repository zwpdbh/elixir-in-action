defmodule Bingo do
  def play(boards_input, drawn_input) do
    players = generate_boards_from_input(boards_input)
    |> Enum.reduce([], fn x, acc ->
      {:ok, pid} = BingoGrid.start_link(x)
      [pid | acc]
    end)

   winner_score =  players 
   |> play_aux(drawn_input)

   players
   |> Enum.each(fn x -> Process.exit(x, :kill) end)

   winner_score
  end

  def play_aux(players, [current_number | rest]) when is_list(players) do
    winner =
      players
      |> Enum.filter(fn each_player ->
        BingoGrid.drawn(each_player, current_number)
      end)

    case length(winner) do
      0 -> play_aux(players, rest)
      1 -> BingoGrid.score(Enum.at(winner, 0), current_number)
      _ -> -1
    end
  end

  def play_aux(_, []) do
    0
  end

  def generate_boards_from_input(boards_input) do
    # IO.inspect boards_input
    boards_input
    |> Enum.filter(fn x -> length(x) == 5 end)
    |> Enum.with_index()
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


# Be careful:
# When there is only one element in the list, process it carefully. I waste 40 mins to check its related error.
# how to access it, how to represent it
