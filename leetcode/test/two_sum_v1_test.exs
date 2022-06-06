defmodule TwoSumVTest do
  use ExUnit.Case

  test "two_sum_easy" do
    assert [0, 1] = TwoSumV1.two_sum([2, 7, 11, 15], 9)
    assert [1, 2] = TwoSumV1.two_sum([3, 2 ,4], 6)
    assert [0, 3] = TwoSumV1.two_sum([0, 4, 3, 0], 0)
    assert [0, 1] = TwoSumV1.two_sum([3, 3], 6)
  end

end
