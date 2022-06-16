defmodule LeetCode04 do
  @spec find_median_sorted_arrays(nums1 :: [integer], nums2 :: [integer]) :: float
  def find_median_sorted_arrays(nums1, nums2) do
   list =  Enum.concat(nums1, nums2)
    |> Enum.sort
    |> Enum.with_index

   compute_median(list, Enum.reverse(list))
  end

  def compute_median([{v1, i1} | _], [{v2, i2} | _]) when i1 >= i2 do
    (v1 + v2) / 2
  end

  def compute_median([{_, i1} | rest01], [{_, i2} | rest02]) when i1 < i2 do
    compute_median(rest01, rest02)
  end

  def compute_median([], []) do
    0
  end
end

# Use pattern-matching from recursive-func to return value!!
