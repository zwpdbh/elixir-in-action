defmodule TwoSum1 do
  @spec two_sum(nums :: [integer], target :: integer) :: [integer]
  def two_sum(nums, target) do
    nums
    |> Enum.with_index
  end


  def test(l)do
    l
    |> Enum.with_index
    |> Enum.sort_by(fn ({x, _}) -> x end)
  end
  
end
