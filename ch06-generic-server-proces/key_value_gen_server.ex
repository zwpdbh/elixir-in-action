defmodule KeyValueStore do
  use GenServer

  @impl GenServer
  def init(_) do
    :timer.send_interva(5000, :cleanup)
    {:ok, %{}}
  end

  # we need to define a handle_info/2 function to process custom plain message.
  @impl GenServer
  def handle_info(:cleanup, state) do
    IO.puts("performing cleanup...")
    {:noreply, state}
  end

  # It is very good practise to specify the @impl attribute for every callback function 
  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl GenServer
  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

  def start do
    # register a local name
    # GenServer.start(KeyValueStore, nil, name: :KeyValueStore)
    GenServer.start(KeyValueStore, nil, name: __MODULE__)
  end

  # def put(pid, key, value) do
  #   GenServer.cast(pid, {:put, key, value})
  # end
  def put(key, value) do
    # GenServer.cast(KeyValueStore, {:put, key, value})

    GenServer.cast(__MODULE__, {:put, key, value})
  end

  # def get(pid, key) do
  #   GenServer.call(pid, {:get, key})
  # end

  # __MODULE__ will be replaced with the name of the module where the code resides:
  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end
end

{:ok, pid} = KeyValueStore.start()
KeyValueStore.put(pid, :some_key, :some_value)
KeyValueStore.get(pid, :some_key)
