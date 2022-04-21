defmodule SonarBinaryDiagnosticTest do
  use ExUnit.Case, async: true

  setup do
    {:ok,
     input01: [
       "00100",
       "11110",
       "10110",
       "10111",
       "10101",
       "01111",
       "00111",
       "11100",
       "10000",
       "11001",
       "00010",
       "01010"
     ]}
  end

  describe "part one" do
    test "baseline", %{input01: binary_records} do
       assert 198 == SonarBinaryDiagnostic.power_consumption(binary_records)
    end
  end
end
