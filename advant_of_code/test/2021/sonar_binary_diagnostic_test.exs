defmodule SonarBinaryDiagnosticTest do
  use ExUnit.Case, async: true

  setup do
    large_input = File.read!("./test/2021/sonar_binary_diagnostic_input.txt")
    |> String.split("\n")
    
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
     ],
     input02: large_input}
  end

  describe "part one" do
    test "baseline", %{input01: binary_records} do
       assert 198 == SonarBinaryDiagnostic.power_consumption(binary_records)
    end

    test "large_input", %{input02: binary_records} do
      assert 3320834 == SonarBinaryDiagnostic.power_consumption(binary_records)
    end


    test "init_gamma" do
      assert %{0 => [], 1 => [], 2 => []} == SonarBinaryDiagnostic.init_gamma([0, 1, 2], %{})
    end
    
    test "append_record" do
      acc = %{}
      acc = 0..4
      |> Enum.to_list
      |> SonarBinaryDiagnostic.init_gamma(acc)

      assert %{0 => ["1"], 1 => ["0"], 2 => ["0"], 3 => ["1"], 4 => ["1"]} == SonarBinaryDiagnostic.append_record_into_acc([{"1", 0}, {"0", 1}, {"0", 2}, {"1", 3}, {"1", 4}], acc)
    end

    test "compute_aux" do
      acc = %{}
      acc = 0..4
      |> Enum.to_list
      |> SonarBinaryDiagnostic.init_gamma(acc)

      expected_result = %{
        0 => ["1", "0", "1"],
        1 => ["1", "1", "0"],
        2 => ["1", "1", "0"],
        3 => ["1", "0", "1"],
        4 => ["1", "0", "1"]
      }
      
      assert expected_result ==  SonarBinaryDiagnostic.compute_aux(["10011", "01100", "11111"], acc)
    end

    test "count_gamma" do
      input = ["0", "1", "1", "1"]
      acc = %{"0" => 0, "1" => 0}
      
      assert %{"0" => 1, "1" => 3} == SonarBinaryDiagnostic.count_gamma(input, acc)
    end

    test "gamma_rate_bit" do
      result = [
        %{"0" => 5, "1" => 7},
        %{"0" => 7, "1" => 5},
        %{"0" => 4, "1" => 8},
        %{"0" => 5, "1" => 7},
        %{"0" => 7, "1" => 5}
      ] 
      |> Enum.map(fn x -> SonarBinaryDiagnostic.gamma_rate_bit(x)end)

      assert ["1", "0", "1", "1", "0"] ==  result 
    end

    test "epsilon_rate_bit" do
      result = [
        %{"0" => 5, "1" => 7},
        %{"0" => 7, "1" => 5},
        %{"0" => 4, "1" => 8},
        %{"0" => 5, "1" => 7},
        %{"0" => 7, "1" => 5}
      ] 
      |> Enum.map(fn x -> SonarBinaryDiagnostic.epsilon_rate_bit(x)end)

      assert ["0", "1", "0", "0", "1"] == result
    end
  end

  describe "part two" do
    test "oxygen baseline", %{input01: records} do
      size = String.length(Enum.at(records, 0))
      assert 23 == SonarBinaryDiagnostic.compute_oxygen_aux(records, 0, size)
    end

    test "co2 baseline", %{input01: records} do
      size = String.length(Enum.at(records, 0))
      assert 10 == SonarBinaryDiagnostic.compute_co2_aux(records, 0, size)
    end

    test "life rate baseline", %{input01: records} do
      assert 230 == SonarBinaryDiagnostic.compute_life_support(records)
    end

    test "life rate with large input", %{input02: large_input} do
       assert 4481199 == SonarBinaryDiagnostic.compute_life_support(large_input)
    end
  end
end
