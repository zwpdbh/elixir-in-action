defmodule PM do
  def match_tuples do
    # The return value will be the right-side term matching agaist if everyting is fine.
    {name, age} = {"Bob", 25}
  end

  def area({:rectangle, a, b}) do
    a * b
  end

  def area({:square, a}) do
    a * a
  end

  def area({:circle, r}) do
    r * r * 3.14
  end

  def area(unknown) do
    {:error, {:unknown_shape, unknown}}
  end

  defmodule TestNum do
    def test(x) when is_number(x) and x < 0 do
      :negative
    end

    def test(0) do
      :zero
    end

    def test(x) when is_number(x) and x > 0 do
      :positive
    end
  end
end

# iex(34)> PM.area({:rectangle, 4, 5})
# PM.area({:rectangle, 4, 5})
# 20
# iex(35)> PM.area({:circle, 10})
# PM.area({:circle, 10})
# 314.0
# iex(36)> PM.area({:square, 11})
# PM.area({:square, 11})
# 121

# fun = &PM.area/1
# fun.({:circle, 4})
# fun.({:circle, 4})
# 50.24

# fun.({:square, 4})
# fun.({:square, 4})
# 16

# fun.({:square, 4, 5})
# fun.({:square, 4, 5})
# {:error, {:unknown_shape, {:square, 4, 5}}}

# iex(43)> TestNum.test(-1)
# TestNum.test(-1)
# :negative
# iex(44)> TestNum.test(0)
# TestNum.test(0)
# :zero

defmodule Polymorphic do
  def double(x) when is_number(x) do
    2 * x
  end

  def double(x) when is_binary(x) do
    x <> x
  end
end

# iex(5)> Polymorphic.double(3)
# Polymorphic.double(3)
# 6
# iex(6)> Polymorphic.double("zw")
# Polymorphic.double("zw")
# "zwzw"

# pattern mathching in function is very useful to define recursive method
defmodule Fact do
  def fact(0) do
    1
  end

  def fact(n) do
    n * fact(n - 1)
  end
end

# == Sometimes, it is more useful to create classic branch construct 
# =if=
# if condition do
#   ...
# else  
#   ...
# end

# =if inline 
# if condition, do: something, else: another thing
if 5 < 4 do
  :one
else
  :two
end
