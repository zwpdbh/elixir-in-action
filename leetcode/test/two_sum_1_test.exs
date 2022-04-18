defmodule TwoSum1Test do
  use ExUnit.Case

  test "two_sum_easy" do
    assert [0, 1] = TwoSum1.two_sum([2, 7, 11, 15], 9)
    assert [1, 2] = TwoSum1.two_sum([3, 2 ,4], 6)
    assert [0, 1] = TwoSum1.two_sum([3, 3], 6)
  end

end
