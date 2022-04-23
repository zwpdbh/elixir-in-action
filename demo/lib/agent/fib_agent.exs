# From Chapter 15. Working with Multiple Processes • 216, Elixir Programming
# Agent that makes it easy to wrap a process containing state in a nice module interface.
defmodule FibAgent do
  def start_link do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end)
  end

  def fib(pid, n) when n >= 0 do
    Agent.get_and_update(pid, fn state -> do_fib(state, n) end)
  end

  defp do_fib(cache, n) do
    case cache[n] do
      nil ->
        {n_1, cache} = do_fib(cache, n - 1)
        {n_2, cache} = do_fib(cache, n - 2)
        result = n_1 + n_2
        {result, Map.put(cache, n, result)}

      cached_value ->
        {cached_value, cache}
    end
  end
end

{:ok, agent} = FibAgent.start_link()
IO.puts(FibAgent.fib(agent, 2000))
