defmodule BingoGrid do
  use GenServer

  def start_link(grid_inputs) when is_list(grid_inputs) do
    GenServer.start(__MODULE__, grid_inputs)
  end

  # each grid_inputs is a row of the grid, so grid_inputs is a list of list number
  def init(grid_inputs) do
    # how to represent the grid
    grid = grid_inputs
    |> Enum.with_index
    |> Enum.reduce(%{}, fn x, acc -> add_row_elements_to_map(x, acc) end)
    
    {:ok, grid}
  end

  defp add_row_elements_to_map({row_nums, r}, grid) do
    row_nums
    |> Enum.with_index
    |> Enum.reduce(grid, fn {num, c}, acc ->
      Map.put_new(acc, {r, c}, {num, false})
    end)
  end
end
