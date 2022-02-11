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