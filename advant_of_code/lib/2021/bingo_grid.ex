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

    {:ok, grid}
  end

  def draw(pid, n) do
    GenServer.call(pid, {:draw, n})
  end

  # key is the {x, y} position on grid
  def win?(pid, key) do
    GenServer.call(pid, {:win?, key})
  end

  def handle_call({:draw, n}, _from, grid) do
    matched =
      grid
      |> Enum.filter(fn {_, {num, _}} -> num == n end)

    case matched do
      [{key, {n, _}}] ->
        {:reply, {:ok, key},
         Map.get_and_update(grid, key, fn current_value -> {current_value, {n, true}} end)}

      _ ->
        {:reply, {:miss, n}, grid}
    end
  end

  def handle_call({:win?, {r, c}}, _from, grid) do
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

    if Enum.length(row_visited) == 5 or Enum.length(col_visited) == 5 do
      {:reply, true, grid}
    else
      {:reply, false, grid}
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
