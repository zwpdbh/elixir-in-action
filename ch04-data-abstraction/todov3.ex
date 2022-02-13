# todo-lit will be represented as a struct(a special map) with two fields
# a auto_id and entries where 
# entries is a map which its key is the entry's id
defmodule TodoList do
  defstruct auto_id: 1, entries: %{}
  
  def new() do
    %TodoList{}
  end
  
  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    
    new_entries = Map.put(
      todo_list.entries,
      todo_list.auto_id,
      entry
    )
    
    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end
  
  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end
  
  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end
  
  def update_entry(todo_list, entry_id, updater_fn) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error -> todo_list
      {:ok, old_entry} ->
        # Here, we are using nested pattern matching. 
        # we make sure the updater lambda be a map.
        # ^var means matching on the value of the variable.
        # so, we also make sure the id doesn't change in the lambda.
        old_entry_id = old_entry.id 
        new_entry = %{id: ^old_entry_id} = updater_fn.(old_entry)
        
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end
  
  
end

todo_list = TodoList.new() |>
  TodoList.add_entry(%{date: ~D[2018-12-19], title: "Denties"}) |>
  TodoList.add_entry(%{date: ~D[2018-12-20], title: "Shopping"}) |>
  TodoList.add_entry(%{date: ~D[2018-12-19], title: "Movies"})
  
TodoList.entries(todo_list, ~D[2018-12-19])
# Data abstraction is achieved because instead of passing individual fileds of an entry, we encapulate it into one argument entry.

put_in(todo_list[2].title, "Theater")