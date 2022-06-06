defmodule Common do
  def permute([]) do
    [[]]
  end

  def permute(list) do
    list
    |> Enum.reduce([], fn e, acc ->
      permute(list -- [e])
      |> Enum.map(fn x -> Enum.concat(x, [e]) end)
      |> Enum.concat(acc)
    end)
  end

  def permuteV2(list) do
    for h <- list, t <- permute(list -- [h]), do: [h | t]
  end
end
