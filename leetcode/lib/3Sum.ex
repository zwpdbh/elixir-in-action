defmodule ThreeSum do
  # https://leetcode.com/problems/3sum/
  @spec three_sum(nums :: [integer]) :: [[integer]]
  def three_sum(nums) do
    three_sum_aux(nums)
  end

  def three_sum_aux([]) do
    []
  end

  def three_sum_aux([_]) do
    []
  end

  def three_sum_aux([_, _]) do
    []
  end

  def three_sum_aux(nums) do
    nums_with_index =
      nums
      |> Enum.with_index()

    result =
      for x <- nums_with_index,
          y <- nums_with_index -- [x],
          z <- nums_with_index -- [x, y],
          reduce: [] do
        acc ->
          {v1, i1} = x
          {v2, i2} = y
          {v3, i3} = z

          case v1 + v2 + v3 == 0 and i1 < i2 and i2 < i3 do
            true ->
              [[v1, v2, v3] | acc]

            false ->
              acc
          end
      end

    result
    |> Enum.uniq_by(fn x -> Enum.sort(x) end)
  end
end

# defmodule Result do
#   use Agent

#   def start_link() do
#     Agent.start_link(fn -> [] end, name: __MODULE__)
#   end

#   def add(e) do
#     Agent.update(__MODULE__, fn acc ->
#       [e | acc]
#     end)
#   end

#   def get() do
#     Agent.get(__MODULE__, fn acc -> acc end)
#   end
# end
