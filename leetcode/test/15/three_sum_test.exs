defmodule ThreeSumTest do
  use ExUnit.Case, async: true

  describe "baseline" do
    test "01" do
      assert [[0, 1, -1], [-1, 2, -1]] = ThreeSum.three_sum([-1, 0, 1, 2, -1, -4])
      assert [] = ThreeSum.three_sum([])
      assert [] = ThreeSum.three_sum([0])

      assert [[0,0,0]] = ThreeSum.three_sum([0, 0, 0])
    end
  end
end
