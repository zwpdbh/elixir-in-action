defmodule TwoSumV1 do
  # @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  # def two_sum(nums, target) do
  #   two_sum_aux(nums, target)
  # end

  # def two_sum_aux(nums, 0) do
  #   nums
  #   |> Enum.with_index
  #   |> Enum.filter(fn {v, _} -> v == 0 end)
  #   |> Enum.map(fn {_, i} -> i end)
  # end

  
  # def two_sum_aux(nums, target) do
  #   lst =
  #     nums
  #     |> Enum.with_index()
  #     |> Enum.sort(&(&1 > &2))

  #   {v, i} = Enum.find(lst, fn {v, _} -> v <= target end)

  #   case find_one(Enum.take(lst, -1 * (i-1)), target - v) do
  #     false -> two_sum_aux(Enum.take(nums, -1 * i), target)
  #     {_, j} -> [j, i]
  #   end
  # end

  # def find_one(lst, target) do
  #   Enum.find(lst, false, fn {v, _} -> v == target end)
  # end

  def permute([]) do
    []
  end

  def permute(lst) do
    for el <- lst, rest <- permute(lst--[el]) do
      [el | rest]
    end
  end
end
