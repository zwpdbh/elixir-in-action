defmodule OurNewApp.CounterSup do
  use Supervisor

  def start_link(start_numbers) do
    Supervisor.start_link(__MODULE__, start_numbers, name: __MODULE__)
  end

  @impl true
  def init(start_numbers) do
    children =
    for start_number <- start_numbers do
      Supervisor.child_spec({OurNewApp.Counter, start_number}, id: start_number, restart: :transient)
    end
    Supervisor.init(children, strategy: :one_for_one)
  end
end
