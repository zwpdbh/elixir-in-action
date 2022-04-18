defmodule SonarSweep do
  # part one 
  def find_increased(records) do
    find_increased_aux(records, 0)
  end

  def find_increased_aux([x, y | tail], current) do
    if x < y do
      find_increased_aux([y | tail], current + 1)
    else
      find_increased_aux([y | tail], current)
    end
  end

  def find_increased_aux([_ | tail], current) when tail == [] do
    current
  end

  # part two: https://adventofcode.com/2021/day/1#part2
  def find_increased02(records) do
    find_increased_aux02(records, 0)
  end

  def find_increased_aux02([x1, x2, x3, x4 | tail], current) do
    part1 = x1 + x2 + x3
    part2 = x2 + x3 + x4
    if part1 < part2 do
      find_increased_aux02([x2, x3, x4 | tail], current + 1)
    else
      find_increased_aux02([x2, x3, x4 | tail], current)
    end
  end

  def find_increased_aux02([_, _, _ | tail], current) when tail == [] do
    current
  end
end
