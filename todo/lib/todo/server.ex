defmodule Todo.Server do
  def start do
    spawn(fn -> loop(Todo.List.new()) end)
  end

  # for each request we want to support, we have to 
  # 1) add a dedicated clause in the process_message/2 function 
  # 2) add a corresponding interface function 

  def add_entry(todo_server, new_entry) do
    send(todo_server, {:add_entry, new_entry})
  end

  def entries(todo_server, date) do
    send(todo_server, {:entries, self(), date})

    receive do
      {:todo_entries, entries} -> entries
    after
      5000 -> {:error, :timeout}
    end
  end

  defp process_message(todo_list, {:add_entry, new_entry}) do
    Todo.List.add_entry(todo_list, new_entry)
  end

  defp process_message(todo_list, {:entries, caller, date}) do
    send(caller, {:todo_entries, Todo.List.entries(todo_list, date)})
    todo_list
  end

  # TODO:: add other interface and server process

  defp loop(todo_list) do
    new_todo_list =
      receive do
        message -> process_message(todo_list, message)
      end

    loop(new_todo_list)
  end
end
