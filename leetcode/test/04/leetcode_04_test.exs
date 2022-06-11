defmodule LeetCode04Test do
  use ExUnit.Case, async: true

  describe "baseline test" do
    test "case 01" do
      assert 2.0 == LeetCode04.find_median_sorted_arrays([1, 3], [2])
    end

    test "case 02" do
      assert 2.5 == LeetCode04.find_median_sorted_arrays([1, 2], [3, 4])
    end
  end
end
