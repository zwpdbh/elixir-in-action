defmodule Leetcode03.Test do
  use ExUnit.Case, async: true

  describe "baseline" do
    test "case 01" do
      assert 3 == Leetcode03.length_of_longest_substring("abcabcbb")
    end
  end
end
