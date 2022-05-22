defmodule BingoGridTest do
  import BingoGrid
  use ExUnit.Case, async: true

  setup do
    small_boards_input =
      File.read!("./test/2021/bingo_small_boards_input.txt")
      |> String.split("\n")
      |> Enum.map(fn x ->
        x
        |> String.trim()
        |> String.split(" ")
        |> Enum.reduce([], fn x, acc ->
          case Integer.parse(x) do
            {n, _} -> Enum.concat(acc, [n])
            _ -> acc
          end
        end)
      end)
      |> Enum.filter(fn x -> length(x) == 5 end)

    big_boards_input =
      File.read!("./test/2021/bingo_big_boards_input.txt")
      |> String.split("\n")
      |> Enum.map(fn x ->
        x
        |> String.trim()
        |> String.split(" ")
        |> Enum.reduce([], fn x, acc ->
          case Integer.parse(x) do
            {n, _} -> Enum.concat(acc, [n])
            _ -> acc
          end
        end)
      end)
      |> Enum.filter(fn x -> length(x) == 5 end)

    small_drawn_input =
      File.read!("./test/2021/bingo_small_drawn_input.txt")
      |> String.trim()
      |> String.split(",")
      |> Enum.reduce([], fn x, acc ->
        case Integer.parse(x) do
          {n, _} -> Enum.concat(acc, [n])
          _ -> acc
        end
      end)

    big_drawn_input =
      File.read!("./test/2021/bingo_big_drawn_input.txt")
      |> String.trim()
      |> String.split(",")
      |> Enum.reduce([], fn x, acc ->
        case Integer.parse(x) do
          {n, _} -> Enum.concat(acc, [n])
          _ -> acc
        end
      end)

    {:ok,
     grid_input: [
       [14, 21, 17, 24, 4],
       [10, 16, 15, 9, 19],
       [18, 8, 23, 26, 20],
       [22, 11, 13, 6, 5],
       [2, 0, 12, 3, 7]
     ],
     drawn_input: [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24],
     small_boards_input: small_boards_input,
     small_drawn_input: small_drawn_input}
  end

  describe "baseline" do
    test "should win at 24", %{grid_input: grid_input, drawn_input: drawn_input} do
      {:ok, pid} = BingoGrid.start_link(grid_input)

      drawn_input
      |> Enum.each(fn x ->
        if drawn(pid, x) do
          assert x == 24
        else
          assert x != 24
        end
      end)
    end

    test "baseline score", %{grid_input: grid_input, drawn_input: drawn_input} do
      {:ok, pid} = BingoGrid.start_link(grid_input)

      drawn_input
      |> Enum.each(fn x ->
        if drawn(pid, x) do
          assert 4512 == score(pid, x)
        end
      end)
    end

    test "grid generation from input", %{small_boards_input: inputs} do
      boards = Bingo.generate_boards_from_input(inputs)
      assert 3 == length(boards)
    end

    test "assure drawn input", %{small_drawn_input: drawn_input} do
      assert length(drawn_input) ==
               length([
                 7,
                 4,
                 9,
                 5,
                 11,
                 17,
                 23,
                 2,
                 0,
                 14,
                 21,
                 24,
                 10,
                 16,
                 13,
                 6,
                 15,
                 25,
                 12,
                 22,
                 18,
                 20,
                 8,
                 19,
                 3,
                 26,
                 1
               ])
    end

    test "bingo game with small input", %{
      small_boards_input: boards_input,
      small_drawn_input: drawn_input
    } do
      assert 4512 == Bingo.play(boards_input, drawn_input)
    end
  end
end
