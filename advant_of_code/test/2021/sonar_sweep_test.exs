defmodule SonarSweepTest do
  use ExUnit.Case, async: true

  setup do
    large_input =
      File.read!("./test/2021/sonar_sweep_input.txt")
      |> String.split("\n")
      |> Enum.map(&Common.str_to_integer(&1))
      |> Enum.map(fn {n, _} -> n end)

    {:ok,
     input01: [199, 200, 208, 210, 200, 207, 240, 269, 260, 263],
     input02: large_input,
     input03: [607, 618, 618, 617, 647, 716, 769, 792]}
  end

  describe "part one" do
    test "basic", %{input01: records} do
      assert 7 = SonarSweep.find_increased(records)
    end

    test "real case", %{input02: records} do
      solution =
        records
        |> SonarSweep.find_increased()

      assert 1529 = solution
    end
  end

  describe "part two" do
    test "basic", %{input03: records} do
      assert 5 = SonarSweep.find_increased02(records)
    end

    test "real case", %{input02: records} do
      solution =
        records
        |> SonarSweep.find_increased02()

      assert 1567 = solution
    end
  end
end
