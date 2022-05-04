defmodule SonarBinaryDiagnostic do
  # By default, 8 bits (i.e. 1 byte) is used to store each number in a bitstring, but you can manually specify the number of bits via a ::n modifier to denote the size in n bits, or you can use the more verbose declaration ::size(n)
  
  # For example:  <<n::size(4)>> = <<0::1, 0::1, 1::1, 1::1>> => n = 3
  # the decimal number 3 when represented with 4 bits in base 2 would be 0011,
  # which is equivalent to the values 0, 0, 1, 1, each stored using 1 bit
  def get_number_from_bits(bits, m) when is_bitstring(bits) do
    <<n::size(m)>> = bits
    n
  end

  # How to convert a string of 1 and 0 to its 
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
  # num_string is the binary string contains only "1" and "0"
  # use the following pair of functions to convert between binary string to integer back and forth.
  # iex(40)> Integer.to_string(22, 2)
  # Integer.to_string(22, 2)
  # "10110"
  # iex(41)> String.to_integer("10110", 2)
  # String.to_integer("10110", 2)
  # 22
  def get_decimal_from_string(num_str) do
    num_str
    |> extract_bits_from_binary_str
    |> get_number_from_bits(String.length(num_str))
  end

  def init_gamma([h | tail], acc) do
    acc = Map.put(acc, h, [])
    init_gamma(tail, acc)
  end

  def init_gamma([], acc) do
    acc
  end

  def power_consumption(inputs) do
    acc = %{}
    n = String.length(Enum.at(inputs, 0))

    acc =
      0..(n-1)
      |> Enum.to_list()
      |> init_gamma(acc)

    {gamma_str, epsilon_str} =
      compute_aux(inputs, acc)
      |> Enum.map(fn {_, records} -> count_gamma(records, %{"0" => 0, "1" => 0}) end)
      |> Enum.map(fn x -> {gamma_rate_bit(x), epsilon_rate_bit(x)} end)
      |> Enum.reduce({"", ""}, fn {m, n}, {gamma_bits, epsilon_bits} ->
        {gamma_bits <> m, epsilon_bits <> n}
      end)

    String.to_integer(gamma_str, 2) * String.to_integer(epsilon_str, 2)
    # get_decimal_from_string(gamma_str) * get_decimal_from_string(epsilon_str)
  end

  def compute_aux([number_str | tail], acc) do
    digits =
      number_str
      |> String.graphemes()
      |> Enum.with_index()

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

  def append_record_aux([{v, i} | tail], acc) do
    {_, acc} =
      Map.get_and_update!(acc, i, fn current_value -> {current_value, [v | current_value]} end)

    append_record_aux(tail, acc)
  end

  def append_record_aux([], acc) do
    acc
  end

  # acc is a map stores how many 1s or 0s 
  def count_gamma([head | tail], acc) do
    case head do
      "1" ->
        {_, acc} = Map.get_and_update!(acc, "1", fn x -> {x, x + 1} end)
        count_gamma(tail, acc)

      "0" ->
        {_, acc} = Map.get_and_update!(acc, "0", fn x -> {x, x + 1} end)
        count_gamma(tail, acc)
    end
  end

  def count_gamma([], acc) do
    acc
  end

  def gamma_rate_bit(%{"0" => x, "1" => y}) do
    case x > y do
      true -> "0"
      false -> "1"
    end
  end

  def epsilon_rate_bit(%{"0" => x, "1" => y}) do
    case x < y do
      true -> "0"
      false -> "1"
    end
  end
end
