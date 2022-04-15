# (This code has no error handling and no means of terminating the process. I
# just wanted to illustrate passing PIDs and messages between nodes.)
defmodule Ticker do
  @interval 2000
  @name :ticker

  # This is a common pattern: we have a module that is responsible both for
  # 1).spawning a process and  
  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  # 2).providing the external interface to that process.    
  def register(client_pid) do
    # Instead letting client to directly send message to ticker to register, we use this interface function to
    # send message to ourself to decouple the client from the server.
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts("registering #{inspect pid}")
        generator([pid|clients])

    after
      @interval ->
        IO.puts "tick"
        Enum.each(clients, fn client ->
          send client, {:tick}
        end)
        generator(clients)
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "tock in client"
        receiver()
    end
  end
end
