# it is a key/value structure that maps todo list names to todo server pids

defmodule Todo.Cache do
  # remember by implementating 
  use GenServer

  @impl GenServer
  def init(_) do
    {:ok, %{}}
  end

  @impl GenServer
  def handle_call({:server_process, todo_list_name}, _, todo_servers) do
    case Map.fetch(todo_servers, todo_list_name) do
      {:ok, todo_server} ->
        {:reply, todo_server, todo_servers}

      {:error} ->
        {:ok, new_server} = Todo.Server.start()

        {:reply, new_server, Map.put(todo_servers, todo_list_name, new_server)}
    end
  end

  def start do
    GenServer.start(__MODULE__, nil)
  end

  def server_process(cache_pid, todo_list_name) do
    GenSever.call(cache_pid, {:server_process, todo_list_name})
  end
end

# {:ok, cache} = Todo.Cache.start()
Todo.Cache.server_process(cache, "Bob's list")
