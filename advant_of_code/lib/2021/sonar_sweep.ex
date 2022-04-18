defmodule SonarSweep do
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

  def find_increased_aux([], current) do
    current
  end
end
