defmodule SonarPilot02Test do
  use ExUnit.Case, async: true

  setup do
    large_input =
      File.read!("./test/2021/sonar_pilot_input.txt")
      |> String.split("\n")

    {:ok,
     input01: [
       "forward 5",
       "down 5",
       "forward 8",
       "up 3",
       "down 8",
       "forward 2"
     ],
     input02: large_input}
  end

  describe "part two" do
    test "baseline", %{input01: commands} do
      SonarPilot02.start_link(nil)

      for command <- commands do
        SonarPilot02.move(command)
      end

      assert 900 == SonarPilot02.get_position()
    end

    test "large_input", %{input02: commands} do
      SonarPilot02.start_link(nil)

      for command <- commands do
        SonarPilot02.move(command)
      end

      IO.inspect(SonarPilot02.get_position())
    end
  end
end
