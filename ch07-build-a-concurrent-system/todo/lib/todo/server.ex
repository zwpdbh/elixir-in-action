defmodule Todo.Server do
  use GenServer

  @impl GenServer
  def init(_) do
    {:ok, Todo.List.new()}
  end

  @impl GenServer
  def handle_cast({:add_entry, new_entry}, todo_list) do
    new_state = Todo.List.add_entry(todo_list, new_entry)
    {:noreply, new_state}
  end

  # @impl GenServer
  # def handle_cast({:update_entry, new_entry}, todo_list) do
  #   new_state = Todo.List.update_entry(todo_list, new_entry)
  #   {:noreply, new_state}
  # end

  @impl GenServer
  def handle_call({:entries, date}, _, todo_list) do
    {
      :reply,
      Todo.List.entries(todo_list, date),
      todo_list
    }
  end

  def start do
    GenServer.start(Todo.Server, nil)
  end

  def add_entry(todo_server, entry) do
    GenServer.cast(todo_server, {:add_entry, entry})
  end

  def entries(todo_server, date) do
    GenServer.call(todo_server, {:entries, date})
  end

  # Notice that, we could not use __MODULE__ here, unless we want it to be singleton!!!
  # def update_entry(new_entry) do
  #   GenServer.cast(__MODULE__, {:update_entry, new_entry})
  # end
end

# {:ok, todo_server} = Todo.Server.start()
# Todo.Server.add_entry(todo_server, %{date: ~D[2018-12-19], title: "Dentist"})
# Todo.Server.entries(todo_server, ~D[2018-12-19])
