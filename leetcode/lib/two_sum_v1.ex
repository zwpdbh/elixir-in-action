defmodule TwoSumV1 do
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    two_sum_aux(nums, target)
  end

  def two_sum_aux(nums, target) do
    with lst =
           nums
           |> Enum.with_index()
           |> Enum.sort(&(&1 > &2)),
           # |> IO.inspect,
         {v, i} =
           lst
           |> Enum.find(fn {v, _} -> v <= target end) do
      case find_one(Enum.take(lst, -1 * (i + 1)), target - v) do
        false -> two_sum_aux(Enum.take(nums, -1 * i), target)
        {_, j} -> [j, i]
      end
    end
  end

  def find_one(lst, target) do
    IO.inspect lst
    Enum.find(lst, false, fn {v, _} -> v == target end)
  end
end
