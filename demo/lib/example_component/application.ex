defmodule SequenceApplication do
  def start_link do
    Supervisor.start_link([
      {Sequence.Stash, 123},
      %{id: Sequence, start: {Sequence, :start_link, [nil]}},
    ], strategy: :rest_for_one, name: Sequence.Supervisor)
  end
end

# iex(7)> SequenceApplication.start_link
# SequenceApplication.start_link
# {:ok, #PID<0.154.0>}

# # Exit as:
# iex(10)> Process.exit(pid("0.154.0"), :normal)
# Process.exit(pid("0.154.0"), :normal)
# true
