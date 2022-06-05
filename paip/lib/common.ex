defmodule Common do
  def every(fun, lst) do
    Enum.all?(lst, fun)
  end

  def some(fun, lst) do
    Enum.find(lst, false, fun)
  end

  # find all matched element from list for which is tested with target return true
  def find_all(target, lst, test_fun) do
    lst
    |> Enum.filter(fn x -> test_fun.(x, target) end)
  end

  def member(goal, state) do
    state
    |> Enum.find(false, fn x -> goal == x end)
  end
end
