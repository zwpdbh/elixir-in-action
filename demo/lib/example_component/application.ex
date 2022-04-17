defmodule SequenceApplication do
  def start_link do
    Supervisor.start_link([
      %{id: Sequence, start: {Sequence, :start_link, [123]}}
    ], strategy: :one_for_one, name: Sequence.Supervisor)
  end
end
