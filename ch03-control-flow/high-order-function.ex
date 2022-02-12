Enum.map([1, 2, 3], fn x-> 2*x end) # => [2,4,6]

Enum.filter([1, 2, 3], &(rem(&1, 2) == 1)) # => [1, 3]

# Recall that many operators are functions, and we can return an operator into a lambda
Enum.reduce([1, 2, 3], 0, &+/2) #=> 6
Enum.reduce([1, "2", 3], 0,
  fn 
  element, acc when is_number(element) -> acc + element
    _, acc -> acc
  end
)

# If we want to use named function instead of lambda. Notice the "&"
defmodule Test do
  def sum_nums(lst) do
    Enum.reduce(lst, 0, &add_num/2)
  end
  
  defp add_num(n, acc) when is_number(n) do 
    n + acc
  end
  defp add_num(_, acc) do 
    acc
  end
end
