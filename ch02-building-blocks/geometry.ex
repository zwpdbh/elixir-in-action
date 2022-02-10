defmodule Geometry do
  def rectange_area(a, b) do
    a * b
  end
  
  def square_area(a) do
    rectange_area(a, a)
  end 
  
  def area(a) do
    a * a
  end
  
  def area(a, b) do
    a * b
  end
end


defmodule Circle do
  @pi 3.14
  
  def area(r) do
    r * r * @pi
  end
  
  def circumference(r) do
    2* r * @pi
  end
end