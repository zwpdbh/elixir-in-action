# A struct is a special kind of map, it is used to define custom type for pattern matching 
# Pattern matching with struct works much like it does with maps.
# Even struct is in fact a map, it can not be used to match a plain map. 
# However, a plain map can match a struct!

defmodule Fraction do
  defstruct a: nil, b: nil 
  
  def new(a, b) do
    %Fraction{a: a, b: b}
  end
  
  def value(%Fraction{a: a, b: b}) do
    a / b
  end
  
  def add(%Fraction{a: a1, b: b1}, %Fraction{a: a2, b: b2}) do
    new(
      a1 * b2 + a2 * b1,
      b2 * b1
    )
  end
end

Fraction.add(Fraction.new(1, 2), Fraction.new(1, 4)) |> Fraction.value()