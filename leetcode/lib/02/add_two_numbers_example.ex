################
defmodule Solution do
  @spec add_two_numbers(l1 :: ListNode.t | nil, l2 :: ListNode.t | nil) :: ListNode.t | nil
  
  # The zero case
  def add_two_numbers(%ListNode{val: 0, next: nil}, %ListNode{val: 0, next: nil}) do
    %ListNode{val: 0}
  end
                                                                 
  def add_two_numbers(l1, l2) do
    calc_sum(l1, l2) |> make_list()
  end
    
  def calc_sum(l1, l2, mult \\ 1, res \\ 0)
  def calc_sum(nil, nil, _, res), do: res
  def calc_sum(l1, l2, mult, res) do
    calc_sum(
      next(l1),
      next(l2),
      mult * 10,
      mult * (val(l1) + val(l2)) + res
    )
  end

  def make_list(0), do: nil
  def make_list(n) when is_integer(n) do
    d = div(n, 10)
    r = rem(n, 10)
    %ListNode{val: r, next: make_list(d)}
  end
    
  def next(nil), do: nil
  def next(%ListNode{next: n}), do: n
           
  def val(nil), do: 0
  def val(%ListNode{val: v}), do: v
end
