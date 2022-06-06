defmodule ThreeSum do
  # https://leetcode.com/problems/3sum/
  @spec three_sum(nums :: [integer]) :: [[integer]]
  def three_sum(nums) do
    Result.start_link()
    
    three_sum_aux(nums)
  end

  def three_sum_aux([]) do
    []
  end

  def three_sum_aux([_]) do
    []
  end

  def three_sum_aux(nums) do
    for x <- nums, y <- nums -- [x], z <- nums -- [x, y] do
      case x + y + z == 0 do
        true -> Result.add([x,y,z])
        false -> nil
      end
    end

    Result.get()
  end
end


defmodule Result do
  use Agent
  def start_link() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def add(e) do
    Agent.update(__MODULE__, fn acc ->
      [e | acc]
    end)
  end

  def get() do
    Agent.get(__MODULE__, fn acc -> acc end)
  end
end
