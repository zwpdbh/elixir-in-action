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
end
