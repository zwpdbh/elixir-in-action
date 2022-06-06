defmodule TwoSumV1 do
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    nums
    |> Enum.with_index
    |> two_sum_aux(target)
  end

  def two_sum_aux([{v, i} | rest], target) do
    case rest_sum(rest, target - v) do
      {_, j} -> [i, j]
      false -> two_sum_aux(rest, target)
    end
  end

  def two_sum_aux([], _) do
    false
  end

  def rest_sum([{v, i} | _], target) when v == target do
    {v, i}
  end

  def rest_sum([{v, _} | rest], target) when v != target do
    rest_sum(rest, target)
  end

  def rest_sum([], _) do
    false
  end
end
