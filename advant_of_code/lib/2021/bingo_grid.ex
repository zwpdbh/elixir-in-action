defmodule BingoGrid do
  use GenServer

  def start_link(grid_inputs) when is_list(grid_inputs) do
    GenServer.start(__MODULE__, grid_inputs)
  end

  # each grid_inputs is a row of the grid, so grid_inputs is a list of list number
  def init(grid_inputs) do
    # how to represent the grid
    grid =
      grid_inputs
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn x, acc -> add_row_elements_to_map(x, acc) end)

    score = -1
    drawn_number = -1
    {:ok, {grid, score, drawn_number, false}}
  end

  def drawn(pid, n) do
    GenServer.call(pid, {:drawn, n})
  end

  def score(pid) do
    GenServer.call(pid, {:score})
  end

  def handle_call({:score}, _from, {grid, score, drawn_number, finished?}) do
    {:reply, {score, drawn_number}, {grid, score, drawn_number, finished?}}
  end

  # update drawn number and update score if it is win 
  def handle_call({:drawn, n}, _from, {grid, score, drawn_number, false}) do
    with matched <- Enum.filter(grid, fn {_, {num, _}} -> num == n end),
         [{{r, c}, {n, _}}] <- matched,
         {_, new_grid} <- Map.get_and_update(grid, {r, c}, fn current_value -> {current_value, {n, true}} end)
      do
      {finished, new_score} =  win?({r, c}, new_grid)
      case finished do
        true -> {:reply, true, {new_grid, new_score, n, true}}
        false -> {:reply, false, {new_grid, score, drawn_number, false}}
      end

    else
      _ -> {:reply, false, {grid, score, drawn_number, false}}
    end
  end

  def handle_call({:drawn, _}, _from, {grid, score, drawn_number, true}) do
    {:reply, true, {grid, score, drawn_number, true}}
  end

  def win?({r, c}, grid) do
    row_visited =
      grid
      |> Enum.filter(fn {{row, _}, {_, visited?}} ->
        visited? == true && r == row
      end)

    col_visited =
      grid
      |> Enum.filter(fn {{_, col}, {_, visited?}} ->
        visited? == true && col == c
      end)

    if length(row_visited) == 5 or length(col_visited) == 5 do
      total_unmatched_ones =
        grid
        |> Enum.reduce(0, fn {_, {v, matched?}}, acc ->
          case matched? do
            true -> acc
            false -> acc + v
          end
        end)
        with {score, _} =  Map.get(grid, {r, c})do
          {true, total_unmatched_ones * score}
        end
    else
      {false, -1}
    end
  end

  defp add_row_elements_to_map({row_nums, r}, grid) do
    row_nums
    |> Enum.with_index()
    |> Enum.reduce(grid, fn {num, c}, acc ->
      Map.put_new(acc, {r, c}, {num, false})
    end)
  end
end
