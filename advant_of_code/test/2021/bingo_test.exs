defmodule BingoTest do
  use ExUnit.Case, async: true

  setup do
    boards_small_input = File.read!("./test/2021/bingo_small_boards_input.txt")
    |> String.split("\n")

      {:ok,
       boards_input_01: boards_small_input}
  end

  describe "part 01" do
    test "generate_boards", %{boards_input_01: input} do
      IO.inspect Bingo.generate_boards(input)
    end
  end
end
