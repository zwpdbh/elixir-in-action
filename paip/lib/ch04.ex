defmodule GPS.Op do
  defstruct [
    action: nil,
    preconids: [],
    add_lst: [],
    del_lst: []
  ]
end

defmodule GPS do

  def gps() do
  end

  def appropriate?(goal, op = %GPS.Op{}) do
    Common.member(goal, op.add_lst)
  end
  
  def achieve(goal, state, ops) do
    Common.member(goal, state) or Common.some(&GPS.apply_op/1, Common.find_all(goal, ops, &GPS.appropriate?/2))
  end

  def apply_op(op = %GPS.Op{}) do
    case Common.every(&GPS.achieve/3, op.preconids) do
      true ->
        IO.puts "executing ${op.action}"
    end
  end
end
