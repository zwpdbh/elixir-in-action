defmodule SonarBinaryDiagnostic do
  def get_number_from_bits(bits) when is_bitstring(bits) do
    <<n::size(5)>> = bits
    n
  end

  #  convert_string_to_6_digits("10110") => <<12::size(6)>>
  def extract_bits_from_binary_str(num_str) when byte_size(num_str) == 5 do
    [x0, x1, x2, x3, x4] =
      String.graphemes(num_str)
      |> Enum.map(fn x ->
        {n, ""} = Integer.parse(x)
        n
      end)

    <<x0::1, x1::1, x2::1, x3::1, x4::1>>
  end

  # get_decimal_from_string("10110") => 22
  def get_decimal_from_string(num_str) when byte_size(num_str) == 5 do
    num_str
    |> extract_bits_from_binary_str
    |> get_number_from_bits
  end


  def init_gamma([h|tail], acc) do
    acc = Map.put(acc, h, [])
    init_gamma(tail, acc)
  end

  def init_gamma([], acc) do
    acc
  end
  
  def compute_gamma(inputs) do
    acc = %{}
    acc = 0..4
    |> Enum.to_list
    |> init_gamma(acc)
    
    compute_aux(inputs, acc)
  end

  def compute_aux([number_str | tail], acc) do
    digits =
      number_str
      |> String.graphemes()
      |> Enum.with_index

    acc = append_record_into_acc(digits, acc)
    compute_aux(tail, acc)
  end

  def compute_aux([], acc) do
    acc
  end

  # digits is something like: [{"1", 0}, {"0", 1}, {"0", 2}, {"1", 3}, {"1", 4}]
  def append_record_into_acc(digits, acc) do
    append_record_aux(digits, acc)
  end

  def append_record_aux([{v, i}|tail], acc) do
    {_, acc} = Map.get_and_update!(acc, i, fn current_value -> {current_value, [v | current_value]} end)
    append_record_aux(tail, acc)
  end

  def append_record_aux([], acc) do
    acc
  end
end
