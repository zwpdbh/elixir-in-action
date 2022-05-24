defmodule Day06Test do
  use ExUnit.Case, async: true


  describe "part one" do
    test "baseline" do
      assert 5934 == Day06.simulate(Day06.process_input("./test/2021/day06_baseline_input.txt"), 80)
    end
    
    test "part one" do
      assert 358214 ==  Day06.simulate(Day06.process_input("./test/2021/day06_part_one_input.txt"), 80)
    end

    # test "part two" do
    #   IO.inspect Day06.simulate(Day06.process_input("./test/2021/day06_part_one_input.txt"), 256)
    # end
  end
end
