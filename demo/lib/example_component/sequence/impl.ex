# our implementation module which is dedicated to handle business logic.
defmodule Sequence.Impl do
  def next(number) do
    number + 1
  end

  def increment(number, delta) do
    number + delta
  end
end
