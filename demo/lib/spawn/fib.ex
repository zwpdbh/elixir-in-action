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

  # processes are available workers
  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when queue != [] ->
        [next | tail] = queue
        send(pid, {:fib, next, self()})
        schedule_processes(processes, tail, results)

      {:ready, pid} ->
        send(pid, {:shutdown})

        if length(processes) > 1 do
          # we only delete works when there are no more jobs
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end

      {:answer, number, result, _pid} ->
        # When receive an answer from a worker process, we don't need to do anything here except collect result.
        # Because our worker will keep updating its status by send message to us.
        # And we just need to consider different message for different situation
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

defmodule TestFib do
  def test do
    to_process = List.duplicate(37, 20)

    Enum.each(1..10, fn num_processes ->
      {time, result} =
        :timer.tc(
          Scheduler,
          :run,
          [num_processes, FibSolver, :fib, to_process]
        )

      if num_processes == 1 do
        IO.puts(inspect(result))
        IO.puts("\n # time (s)")
      end

      :io.format("~2B ~.2f~n", [num_processes, time / 1_000_000.0])
    end)
  end
end
