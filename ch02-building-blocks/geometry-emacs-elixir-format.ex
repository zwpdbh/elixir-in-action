defmodule Geometry do
  def rectange_area(a, b) do
    a * b
  end

  def square_area(a) do
    rectange_area(a, a)
  end
end
