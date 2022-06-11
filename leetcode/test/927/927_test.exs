defmodule LeetCode927Test do
  use ExUnit.Case, async: true

  describe "baseline" do
    test "case 01" do
      assert [0,3] == LeetCode927.three_equal_parts([1,0,1,0,1])
    end

    test "case 02" do
      assert [-1, -1] == LeetCode927.three_equal_parts([1,1,0,1,1])
    end

    test "case 03" do
      assert [0, 2] == LeetCode927.three_equal_parts([1,1,0,0,1])
    end
  end
end
