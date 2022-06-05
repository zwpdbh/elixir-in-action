defmodule GPS.Op do
  defstruct [
    # represent the action 
    action: nil,
    # represent the precondition need to be met to take such action 
    preconds: [],
    # represent things needed to be added to global state after taking this action
    add_lst: [],
    # represent things needed to be removed from global state after taking this action
    del_lst: []
  ]
end

defmodule GPSAgent do
  use Agent

  def start_link({state, ops}) do
    Agent.start_link(fn -> {state, ops} end, name: __MODULE__)
  end

  def update_state_after_op(op) do
    Agent.update(__MODULE__, fn {state, ops} ->
      updated_state =
        MapSet.difference(MapSet.new(state), MapSet.new(op.del_lst))
        |> MapSet.union(MapSet.new(op.add_lst))
        |> MapSet.to_list()

      {updated_state, ops}
    end)
  end

  def get_state do
    Agent.get(__MODULE__, fn {state, _} -> state end)
  end

  def get_ops do
    Agent.get(__MODULE__, fn {_, ops} -> ops end)
  end
end

defmodule GPS do
  def gps(state, goals, ops) do
    GPSAgent.start_link({state, ops})

    case Enum.all?(goals, fn x -> achieve(x) end) do
      true ->
        IO.puts("SOLVED")
        "solved"

      false ->
        IO.puts("NOT SOLVED")
        "not solved"
    end
  end

  def appropriate?(goal, op = %GPS.Op{}) do
    # "An op is appropriate to a goal if it is in its add list."
    op.add_lst
    |> Enum.find(false, fn x -> goal == x end)
  end

  def achieve(goal) do
    #  "A goal is achieved if it already holds, or if there is an appropriate op for it that is applicable."
    case Enum.find(GPSAgent.get_state(), false, fn x -> goal == x end) do
      false ->
        GPSAgent.get_ops()
        |> Enum.filter(fn x -> appropriate?(goal, x) end)
        |> Enum.find(false, fn x -> applicable_op(x) end)

      _ ->
        # IO.puts("#{goal} is already achieved")
        true
    end
  end

  def applicable_op(op = %GPS.Op{}) do
    # "Print a message and update *state* if op is applicable."
    case Enum.all?(op.preconds, fn x -> achieve(x) end) do
      # be careful, here achieve one goal could undo previously achieved goal
      true ->
        IO.puts("executing '#{op.action}'")
        # How to update some global state
        GPSAgent.update_state_after_op(op)
        true

      false ->
        nil
    end
  end
end


defmodule GPSV2 do
  # To solve sibling goal problem
  # But it still has leap before you look problem:
  # For example: if the goal is (jump-off-cliff land-safely), think about it.
  # The problem arises because planning and execution are interleaved.
  defp achieve_all(goals) do
    Enum.all?(goals, fn x -> achieve(x) end) and MapSet.subset?(MapSet.new(goals), MapSet.new(GPSAgent.get_state))
  end
  
  def gps(state, goals, ops) do
    GPSAgent.start_link({state, ops})

    case achieve_all(goals) do
      true ->
        IO.puts("SOLVED")
        "solved"

      false ->
        IO.puts("NOT SOLVED")
        "not solved"
    end
  end

  def appropriate?(goal, op = %GPS.Op{}) do
    # "An op is appropriate to a goal if it is in its add list."
    op.add_lst
    |> Enum.find(false, fn x -> goal == x end)
  end

  def achieve(goal) do
    #  "A goal is achieved if it already holds, or if there is an appropriate op for it that is applicable."
    case Enum.find(GPSAgent.get_state(), false, fn x -> goal == x end) do
      false ->
        GPSAgent.get_ops()
        |> Enum.filter(fn x -> appropriate?(goal, x) end)
        |> Enum.find(false, fn x -> applicable_op(x) end)

      _ ->
        # IO.puts("#{goal} is already achieved")
        true
    end
  end

  def applicable_op(op = %GPS.Op{}) do
    # "Print a message and update *state* if op is applicable."
    case achieve_all(op.preconds) do
      # be careful, here achieve one goal could undo previously achieved goal
      true ->
        IO.puts("executing '#{op.action}'")
        # How to update some global state
        GPSAgent.update_state_after_op(op)
        true

      false ->
        nil
    end
  end
end
