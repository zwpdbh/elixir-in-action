defmodule OurNewAppTest do
  use ExUnit.Case
  doctest OurNewApp

  test "greets the world" do
    assert OurNewApp.hello() == :world
  end
end
