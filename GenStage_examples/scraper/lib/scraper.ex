defmodule Scraper do
  @moduledoc """
  Documentation for `Scraper`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Scraper.hello()
      :world

  """
  def hello do
    :world
  end

  def work() do
    1..5
    |> Enum.random()
    |> :timer.seconds()
    |> Process.sleep()
  end
end
