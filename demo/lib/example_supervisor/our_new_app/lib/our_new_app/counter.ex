defmodule OurNewApp.Counter do
  use GenServer
  require Logger

  @interval 100

  def start_link(start_from, opts \\ []) do
    GenServer.start_link(__MODULE__, start_from, opts)
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def init(start_from) do
    # Must enable flag to handle process termination.
    Process.flag(:trap_exit, true)
    
    st = %{
      current: start_from,
      timer: :erlang.start_timer(@interval, self(), :tick)
    }

    {:ok, st}
  end

  def handle_call(:get, _from, st) do
    {:reply, st.current, st}
  end

  def handle_info({:timeout, _timer_ref, :tick}, st) do
    new_timer = :erlang.start_timer(@interval, self(), :tick)
    :erlang.cancel_timer(st.timer)
    {:noreply, %{st | current: st.current + 1, timer: new_timer}}
  end

  def terminate(reason, st) do
     Logger.info("terminating with #{inspect(reason)}, counter is #{st.current}")
  end
end
