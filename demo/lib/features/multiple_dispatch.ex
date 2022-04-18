# So, this module with Behaviour could achieve m by n functions.
# We define m modules to implement n callbacks 
defmodule MultiDispatch do
  @callback prepare_it({Any, Any, Any}) :: {:ok, String.t}
  @callback prepare_it({Any, Any}) :: {:ok, String.t}

  def prepare(some_type, some_value) do
    some_type_impl = prepare_for(some_type)
    some_type_impl.prepare_it(some_value)
  end

  def prepare_for(:coffee) do
    MultiDispatch.Coffee
  end

  def prepare_for(:tea) do
    MultiDispatch.Tea
  end
end


defmodule MultiDispatch.Coffee do
  @behaviour MultiDispatch

  @impl MultiDispatch
  def prepare_it({x, _y, _z}) do
    {:ok, "#{x}"}
  end

  @impl MultiDispatch
  def prepare_it({x, y}) do
    {:ok, "#{x} * #{y}"}
  end
end


defmodule MultiDispatch.Tea do
  @behaviour MultiDispatch

  def prepare_it({x, _y, _z}) do
    {:ok, "minus #{x}"}
  end

  def prepare_it({x, y}) do
    {:ok, "#{x} / #{y}"}
  end
end

defmodule MultiDispatch.Demo do
  def test do
    IO.inspect MultiDispatch.prepare(:coffee, {10, 20})
    IO.inspect MultiDispatch.prepare(:coffee, {10, 20, 30})

    IO.inspect MultiDispatch.prepare(:tea, {10, 20})

    MultiDispatch.prepare(:tea, {10, 20, 30})
  end
end


