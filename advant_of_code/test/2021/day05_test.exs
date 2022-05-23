defmodule Day05Test do
  use ExUnit.Case, async: true

  setup do
    baseline_input = File.read!("./test/2021/day05_baseline_input.txt")
    big_input_part_one = File.read!("./test/2021/day05_part_one_input.txt")

    {:ok, baseline_input: baseline_input, big_input_part_one: big_input_part_one}
  end

  describe "part one" do
    test "baseline", %{baseline_input: baseline_input} do
      assert 5 == baseline_input
      |> Day05.process_input
      |> Day05.produce_points_from_lines
      |> Day05.compute_overlap_points
    end

    test "part one", %{big_input_part_one: big_input_part_one} do
    assert 6710  ==  big_input_part_one
      |> Day05.process_input
      |> Day05.produce_points_from_lines
      |> Day05.compute_overlap_points
    end
  end
end
