defmodule FibSolver do
  def fib(scheduler) do
    send(scheduler, {:ready, self()})

    receive do
      {:fib, n, client} ->
        send(client, {:answer, n, fib_calc(n), self()})
        fib(scheduler)

      {:shutdown} ->
        exit(:normal)
    end
  end

  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1

  defp fib_calc(n) do
    fib_calc(n - 1) + fib_calc(n - 2)
  end
end

defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    1..num_processes
    |> Enum.map(fn _ -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end
end



to_process = List.duplicate(37, 20)
Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(Scheduler, :run, [num_processes, FibSolver, :fib, to_process])

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #   times (s)"
  end
  :io.format "~2B     ~.2f~n", [num_processes, time/100000.0]
end
