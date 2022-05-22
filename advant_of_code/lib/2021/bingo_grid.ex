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
    {:ok, grid, score, drawn_number}
  end

  def drawn(pid, n) do
    case GenServer.call(pid, {:drawn, n}) do
      {:ok, key} -> win?(pid, key)
      _ -> false
    end
  end

  # key is the {x, y} position on grid
  def win?(pid, key) do
    GenServer.call(pid, {:win?, key})
  end

  def score(pid, drawn_num) do
    GenServer.call(pid, {:score, drawn_num})
  end

  def handle_call({:score, drawn_num}, _from, grid) do
    
    {:reply, score, grid}
  end

  # update drawn number and update score if it is win 
  def handle_call({:drawn, n}, _from, {grid, score, drawn_number}) do
    # matched is the record matched in the map: {x, y} => {drawn_number, visited?}
    case score != -1 do
      true ->
        {:reply, {grid, score, drawn_number}}

      false ->
        matched =
          grid
          |> Enum.filter(fn {_, {num, _}} -> num == n end)

        case matched do
          [{{r, c}, {n, _}}] ->
            {_, new_grid} =
              Map.get_and_update(grid, {r, c}, fn _ -> {_, {n, true}} end)

            case win?({r, c}, new_grid) do
              {true, new_score} -> {:reply, {new_grid,new_score, n}}
              {false, -1} -> {:reply, {new_grid, -1, n}}
            end
          _ ->
            {:reply, {grid, score, drawn_number}
       end
    end
  end

  def win?({r, c},  grid) do
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

      {true, total_unmatched_ones * Map.get({r, c})}
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
