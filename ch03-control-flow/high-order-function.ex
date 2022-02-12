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

# If we want to use named function instead of lambda
defmodule Test do
  def my_add(e, acc) do
    if is_number(e) do
      e + acc 
    else 
      acc
    end
  end
end
Enum.reduce([1, "2", 3], 0, &Test.my_add/2)