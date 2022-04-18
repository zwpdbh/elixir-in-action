defmodule SonarSweepTest do
  use ExUnit.Case

  test "basic" do
    assert 7 = SonarSweep.find_increased([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
  end

  test "real case" do
    solution = File.read!("./test/2021/sonar_sweep_input.txt")
    |> String.split("\n")
    |> Enum.map(&to_integer(&1))
    |> Enum.map(fn {n, _} -> n end)
    |> SonarSweep.find_increased

    assert 1529 = solution
  end

  def to_integer(x) when x == "" do
    {0, ""}
  end

  def to_integer(x) do
    Integer.parse(x)
  end
end
