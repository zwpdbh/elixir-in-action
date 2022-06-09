# Definition for singly-linked list.
defmodule ListNode do
  @type t :: %__MODULE__{
          val: integer,
          next: ListNode.t() | nil
        }
  defstruct val: 0, next: nil
end

defmodule AddTwoNumbers do
  @spec add_two_numbers(l1 :: ListNode.t() | nil, l2 :: ListNode.t() | nil) :: ListNode.t() | nil
  def add_two_numbers(l1, l2) do
    {n1, _} = list_to_num(l1)
    {n2, _} = list_to_num(l2)
    num_to_list(n1 + n2)
  end

  def list_to_num(lst) do
    {n, _} =
      lst
      |> Enum.reverse()
      |> Enum.join("")
      |> Integer.parse()

    n
  end

  def num_to_list(n) do
    "#{n}"
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.map(fn x ->
      {n, _} = Integer.parse(x)
      n
    end)
  end
end


# To make ListNode Enumerable, we need to implement 4 functions:
defimpl Enumerable, for: ListNode do
  def reduce(nil, {:cont, acc}, _fun) do
    {:done, acc}
  end

  def reduce(%{ListNode{} = l}, {:cont, acc}, fun) do
    reduce(l.next, fun.(l.val, acc), fun)
  end

  def reduce(_l, {:halt, acc}, _fun) do
    {:halted, acc}
  end

  def reduce(%ListNode{} = l, {:suspend, acc}, fun) do
    {:suspended, acc, &reduce(l, &1, fun)}
  end
end

defimpl Enumerable, for: ListNode do
  def count(%ListNode{} = l) do
    count_aux(l, 0)
  end

  def count_aux(nil, c) do
    c
  end

  def count_aux(%ListNode{} = l, c) do
    count_aux(l.next, c+1)
  end
end

defimpl Enumerable, for: ListNode do
  def member?(nil, target) do
  end
end
