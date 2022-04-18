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

  # Invoke this function will cause this process to stop "gracefully"
  # which wait until a moment that the current is divisible by 10.
  def stop_gracefully(pid) do
    GenServer.call(pid, :stop_gracefully)
  end

  def init(start_from) do
    # Must enable flag to handle process termination.
    Process.flag(:trap_exit, true)
    
    st = %{
      current: start_from,
      timer: :erlang.start_timer(@interval, self(), :tick),
      terminator: nil
    }

    {:ok, st}
  end

  def handle_call(:get, _from, st) do
    {:reply, st.current, st}
  end

  def handle_call(:stop_gracefully, from, st) do
    if st.terminator do
      {:reply, :already_stopping, st}
    else
      {:noreply, %{st | terminator: from}}
    end
  end

  def handle_info({:timeout, _timer_ref, :tick}, st) do
    :erlang.cancel_timer(st.timer)
    new_current = st.current + 1

    # If we have set the terminator, it means we are planning to stop 
    if st.terminator && rem(new_current, 10) == 0 do
      GenServer.reply(st.terminator, :ok) #??
      {:stop, :normal, %{st | current: new_current, timer: nil}}

    else
      new_timer = :erlang.start_timer(@interval, self(), :tick)
      {:noreply, %{st | current: new_current, timer: new_timer}}      
    end
  end

  def terminate(reason, st) do
     Logger.info("terminating with #{inspect(reason)}, counter is #{st.current}")
  end
end
