defmodule SonarPilotTest do
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

  describe "part one" do
    test "baseline", %{input01: commands} do
      SonarPilot.start_link(nil)

      for command <- commands do
        SonarPilot.move(command)
      end
      
      assert 150 == SonarPilot.get_position()
    end

    test "large input", %{input02: commands} do
      SonarPilot.start_link(nil)

      for command <- commands do
        SonarPilot.move(command)
      end
      assert 2073315 == SonarPilot.get_position()
    end
  end
end
