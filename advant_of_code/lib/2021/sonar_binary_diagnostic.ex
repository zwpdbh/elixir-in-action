defmodule SonarBinaryDiagnostic do
  def get_number_from_6_digits(digits) when is_bitstring(digits) do
    <<n::size(6)>> = digits
    n
  end

  #  convert_string_to_6_digits("001100") => <<12::size(6)>>
  def convert_string_to_6_digits(num_str) when byte_size(num_str) == 6 do
    [x0, x1, x2, x3, x4, x5] =
      String.graphemes(num_str)
      |> Enum.map(fn x ->
        {n, ""} = Integer.parse(x)
        n
      end)

    <<x0::1, x1::1, x2::1, x3::1, x4::1, x5::1>>
  end

  # get_decimal_from_string("001100") => 12
  def get_decimal_from_string(num_str) when byte_size(num_str) == 6 do
    num_str
    |> convert_string_to_6_digits
    |> get_number_from_6_digits
  end

  def power_consumption(binary_numbers) do
    compute_gamma_rate(
      binary_numbers,
      generate_map_of_list(6)
    )
  end

  # produce %{0 => [], 1 => [], ..., n-1 => []}
  # TODO:: how to simply this
  def generate_map_of_list(n) do
    0..n-1
    |> Enum.to_list
    |> generate_map_of_list_aux(%{})
  end

  defp generate_map_of_list_aux([h|tail], m) do
    generate_map_of_list_aux(tail, Map.put_new(m, h, []))
  end

  defp generate_map_of_list_aux([], m) do
    m
  end


  def compute_gamma_rate([number_str | tail], acc) do
    digits =
      number_str
      |> String.graphemes()
      |> Enum.with_index

    # this part has problem
    for {v, i} <- digits do
      Map.get_and_update(acc, i, fn current_value -> {current_value, [v | current_value]} end)
    end
    IO.inspect digits
    
    compute_gamma_rate(tail, acc)
  end

  def compute_gamma_rate([], acc) do
    acc
  end
end
