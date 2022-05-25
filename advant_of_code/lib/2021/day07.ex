defmodule Day07 do
  def process_input(file_name) do
    File.read!(file_name)
    |> String.trim
    |> String.split(",")
    |> Enum.reduce([], fn x, acc ->
      case Integer.parse(x) do
        {n, _} -> [n | acc]
        _ -> acc
      end
    end)
  end
  
  def fuel(crabs) do
    q = Enum.min(crabs)
    r = Enum.max(crabs)

    compute(Enum.sort(crabs), q, r)
  end

  def compute(crabs, q, r) when q < r do
    IO.inspect({q, r})
    k = div(q + r, 2)

    [{v1, i1}, {v2, i2}, {_, _}] =
      [{compute_fuel(crabs, q), q}, {compute_fuel(crabs, k), k}, {compute_fuel(crabs, r), r}]
      |> Enum.sort()
      |> IO.inspect()

    IO.puts("\n")
    case v1 == v2 and i1 == i2 do
      true ->
        v1

      false ->
        # if the smallest is in the middle
        case i1 == k do
          true ->
            [compute(crabs, q, k), compute(crabs, k, r)] |> Enum.min()

          false ->
            case i1 <= i2 do
              true -> compute(crabs, i1, i2)
              false -> compute(crabs, i2, i2)
            end
        end
    end
  end

  def compute(crabs, q, r) when q == r do
    compute_fuel(crabs, q)
  end

  def compute_fuel(crabs, i) do
    crabs
    |> Enum.reduce(0, fn x, acc ->
      acc + abs(x - i)
    end)
  end
end
