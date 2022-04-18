defmodule Common do
  def str_to_integer(x) when x == "" do
    {0, ""}
  end

  def str_to_integer(x) do
    Integer.parse(x)
  end
end
