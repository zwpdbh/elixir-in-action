defmodule PaipTest do
  use ExUnit.Case
  doctest Paip

  test "greets the world" do
    assert Paip.hello() == :world
  end
end
