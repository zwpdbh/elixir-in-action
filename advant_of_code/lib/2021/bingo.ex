defmodule Bingo do
  
  def play(boards_input, drawn_input) do
    players =
      generate_boards_from_input(boards_input)
      |> Enum.reduce([], fn x, acc ->
        {:ok, pid} = BingoGrid.start_link(x)
        [pid | acc]
      end)

    order_look_up =
      drawn_input
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {n, i}, acc ->
        {_, new_acc} = Map.get_and_update(acc, n, fn current_v -> {current_v, i} end)
        new_acc
      end)

    drawn_input
    |> Enum.each(fn n ->
      players
      |> Enum.each(fn each_player -> BingoGrid.drawn(each_player, n) end)
    end)

    winner =
      players
      |> Enum.map(fn each -> BingoGrid.score(each) end)
      |> Enum.min_by(fn {_, drawn_number} -> Map.get(order_look_up, drawn_number) end)

    {score, _} = winner

    cleanup(players)
    score
  end

  def play_last(boards_input, drawn_input) do
    players =
      generate_boards_from_input(boards_input)
      |> Enum.reduce([], fn x, acc ->
        {:ok, pid} = BingoGrid.start_link(x)
        [pid | acc]
      end)

    order_look_up =
      drawn_input
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {n, i}, acc ->
        {_, new_acc} = Map.get_and_update(acc, n, fn current_v -> {current_v, i} end)
        new_acc
      end)

    drawn_input
    |> Enum.each(fn n ->
      players
      |> Enum.each(fn each_player -> BingoGrid.drawn(each_player, n) end)
    end)

    winner =
      players
      |> Enum.map(fn each -> BingoGrid.score(each) end)
      |> Enum.max_by(fn {_, drawn_number} -> Map.get(order_look_up, drawn_number) end)

    {score, _} = winner

    cleanup(players)
    score
  end


  defp cleanup(pids) do
    pids
    |> Enum.each(fn x -> Process.exit(x, :kill) end)
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
