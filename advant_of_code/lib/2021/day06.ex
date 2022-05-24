defmodule Day06 do
  def simulate(fishes, n) do
    fishes
    # |> IO.inspect
    |> simulate_aux(n)
  end

  def simulate_aux(fishes, n) when n > 0 do
    fishes
    |> Enum.reduce([], fn c, acc ->
      case c - 1 >= 0 do
        true -> [c - 1 | acc]
        false -> [6, 8 | acc]
      end
    end)
    |> simulate_aux(n - 1)
  end

  def simulate_aux(fishes, n) when n == 0 do
    fishes
    # |> IO.inspect
    |> length 
  end

  def process_input(file_name) do
    File.read!(file_name)
    |> String.trim
    # |> IO.inspect
    |> String.split(",")
    # |> IO.inspect
    |> Enum.reduce([], fn x, acc ->
      case Integer.parse(x) do
        {n, _} -> Enum.concat(acc, [n])
        _ -> acc
      end
    end)
  end

  # Not fast enough
  def simulate_large(fishes, n) do
    fishes
    |> Enum.frequencies_by(fn x -> x end)
    |> IO.inspect
    |> Enum.reduce(0, fn {k, v}, acc -> acc + v * simulate([k], n) end)
  end
end
