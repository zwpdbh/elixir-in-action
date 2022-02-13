# === spawn
run_query = fn query_def -> 
  Process.sleep(2000)
  "#{query_def} result"
end

spawn(fn -> 
  IO.puts(run_query.("query 1")) 
end)

async_query = fn query_def -> spawn(fn -> IO.puts(run_query.(query_def)) end) end
async_query.("query 1")

Enum.each(1..5, &async_query.("query #{&1}"))

# ==otherway to express it 
defmodule Concurrency do
  def run_query(query_def) do
    Process.sleep(2000)
    "#{query_def} result"
  end
  def async_query(query_def) do
    spawn(fn ->
      IO.puts(run_query(query_def))
    end)
  end
  
  def async_query_v2(query_def) do
    caller = self()
    spawn(fn ->
      send(caller, {:query_result, run_query(query_def)})
    end)
  end
end

Enum.each(1..5, &Concurrency.async_query("query #{&1}"))




# Instead of printing to the screen, make the lambda send the query result to the caller 
Enum.each(1..5, &Concurrency.async_query_v2("query #{&1}"))
get_result = fn ->
  receive do 
    {:query_result, result} -> result
  end
end

results = Enum.map(1..5, fn _ -> get_result.() end)

# a simple parallel map that can be used to process a larger amount of work in parallel
# then collect the results into a list
1..5 |>
  Enum.map(&Concurrency.async_query_v2("query #{&1}")) |>
  Enum.map(fn _ -> get_result.() end)










# server process (see page 141)
defmodule DatabaseServer do
  # This is the "interface" process running in caller process
  def start do
    spawn(&loop/0)
  end
  
  # The purpose of this function is to hide user from aware of message-passing details
  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end    
  
  # This is the "implementation" process running in a server process
  defp loop do 
    receive do 
      # ... handle one message
      {:run_query, caller, query_def} ->
        send(caller, {:query_result, run_query(query_def)})
    end
    
    loop()
  end    
  
  defp run_query(query_def) do 
    Process.sleep(2000)
    "#{query_def} result"
  end
  
  # when the client want to get the query result, use this function.
  def get_result do
    receive do 
      {:query_result, result} -> result 
    after 
      5000 -> {:error, :timeout}
    end
  end
end

server_pid = DatabaseServer.start()
DatabaseServer.run_async(server_pid, "query 1")
DatabaseServer.get_result()
DatabaseServer.run_async(server_pid, "query 2")
DatabaseServer.get_result()

# Notice:
# we should make server process internally sequential. Because it helps us to reason about the system.


# Use pool of server process to handle large load 
# start a server process pool
pool = Enum.map(1..100, fn _ -> DatabaseServer.start() end)

# start to run 5 queries in parallel
Enum.each(
  1..5,
  fn query_def -> 
    server_pid = Enum.at(pool, :random.uniform(100) - 1)
    DatabaseServer.run_async(server_pid, query_def)
  end
)
# from caller process to call 5 times get result to collect them 
Enum.map(1..5, fn _ -> DatabaseServer.get_result() end)