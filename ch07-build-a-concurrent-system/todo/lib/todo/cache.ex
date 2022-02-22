# it is a key/value structure that maps todo list names to todo server pids

defmodule Todo.Cache do
  # remember by implementating 
  use GenServer

  @impl GenServer
  def init(_) do
    Todo.Database.start()
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}

      :error ->
        {:ok, new_server} = Todo.Server.start()
        IO.puts("start a server process for #{todo_list_name}")

        {
          :reply,
          new_server,
          Map.put(todo_servers, todo_list_name, new_server)
        }
    end
  end

  def start do
    # remember the "__MODULE__" will be replaced with the name of the current module.
    # It also make our instance be singleton!!!
    # So Todo.Server can not be singleton here. 
    GenServer.start(__MODULE__, nil)
  end

  def server_process(cache_pid, todo_list_name) do
    GenServer.call(cache_pid, {:server_process, todo_list_name})
  end
end

# {:ok, cache} = Todo.Cache.start()
# Todo.Cache.server_process(cache, "Bob's list")
# Todo.Cache.server_process(cache, "Bob's list")
# Todo.Cache.server_process(cache, "zw's list")

# :erlang.system_info(:process_count)
