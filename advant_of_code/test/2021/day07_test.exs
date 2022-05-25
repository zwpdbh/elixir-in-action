defmodule Day07Test do
  use ExUnit.Case, async: true

  describe "part one" do
    # test "baseline" do
    #   assert 37 =
    #            Day07.process_input("./test/2021/day07_baseline_input")
    #            |> Day07.fuel()
    # end

    test "part one" do
      # my first guess is 364912, is too high.
      IO.inspect(
        Day07.process_input("./test/2021/day07_part_one_input")
        |> Day07.fuel()
      )
    end
  end
end
