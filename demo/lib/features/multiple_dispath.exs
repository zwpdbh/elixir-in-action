# So, this module with Behaviour could achieve m by n functions.
# We define m modules to implement n callbacks 
defmodule MD do
  @callback prepare_it(integer) :: {:ok, String.t}
  @callback prepare_it({integer, integer}) :: {:ok, String.t}

  def prepare(some_type, some_value) do
    some_type_impl = prepare_for(some_type)
    some_type_impl.prepare_it(some_value)
  end

  def prepare_for(:coffee) do
    MD.Coffee
  end

  def prepare_for(:tea) do
    MD.Tea
  end
end


defmodule MD.Coffee do
  @behaviour MD

  @impl MD
  def prepare_it(x) do
    {:ok, "#{x}"}
  end

  @impl MD
  def prepare_it({x, y}) do
    {:ok, "#{x} * #{y}"}
  end
end


defmodule MD.Tea do
  @behaviour MD

  def prepare_it(x) do
    {:ok, "minus #{x}"}
  end

  def prepare_it({x, y}) do
    {:ok, "#{x} / #{y}"}
  end
end


