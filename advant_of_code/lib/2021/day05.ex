defmodule Day05 do
  def convert_to_points({x1, y1}, {x2, y2}) when x1 != x2 and y1 != y2 do
    # Enum.zip(x1..x2, y1..y2)
    []
  end

  def convert_to_points({x1, y1}, {x2, y2}) when x1 == x2 do
    y1..y2
    |> Enum.map(fn m -> {x1, m} end)
  end

  def convert_to_points({x1, y1}, {x2, y2}) when y1 == y2 do
    x1..x2
    |> Enum.map(fn m -> {m, y1} end)
  end

  def compute_overlap_points(line_points) do
    line_points
    |> Enum.reduce([], fn points, acc -> Enum.concat(acc, points) end)
    # |> IO.inspect    
    |> Enum.reduce(%{}, fn point, acc ->
      {_, new_acc} =
        Map.get_and_update(acc, point, fn current ->
          case current do
            nil -> {current, 1}
            n -> {current, n + 1}
          end
        end)

      new_acc
    end)
    # |> IO.inspect
    |> Enum.filter(fn {_, count} -> count > 1 end)
    |> length
  end

  def produce_points_from_lines(lines) do
    lines
    |> Enum.reduce([], fn [p1, p2], acc -> [convert_to_points(p1, p2) | acc] end)
  end

  def process_input(str) do
    str
    |> String.split("\n")
    |> Enum.map(fn eachline ->
      eachline
      |> String.trim()
      |> String.split("->")
    end)
    # => ["7,0 ", " 7,4"],
    |> Enum.filter(fn x -> length(x) == 2 end)
    |> Enum.map(fn coor_pair ->
      coor_pair
      |> Enum.map(fn pair ->
        pair
        |> String.trim()
        # => ["0", "5"]
        |> String.split(",")
        |> Enum.map(fn str ->
          case Integer.parse(str) do
            {d, _} -> d
            _ -> "Invalid digit"
          end
        end)
      end)
    end)
    |> Enum.map(fn [[x1, y1], [x2, y2]] -> [{x1, y1}, {x2, y2}] end)
  end
end
