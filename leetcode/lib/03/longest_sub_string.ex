defmodule Leetcode03 do
  @spec length_of_longest_substring(s :: String.t()) :: integer
  def length_of_longest_substring(s) do
    {n, _} =
      s
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce({0, %{}}, fn {v, i}, {result, acc} ->
        case Map.fetch(acc, v) do
          :error ->
            new_acc = Map.put_new(acc, v, i)

            case Enum.count(new_acc) > result do
              true -> {Enum.count(new_acc), new_acc}
              false -> {result, new_acc}
            end

          {:ok, k} ->
            new_acc =
              acc
              |> Enum.filter(fn {_, index} -> index > k end)
              |> Map.new()
              |> Map.put_new(v, i)

            {result, new_acc}
        end
      end)

    n
  end
end
