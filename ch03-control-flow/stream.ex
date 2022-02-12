# This create a stream( lazy enumerable)
stream = [1, 2, 3] |> Stream.map(fn x -> x * 2 end)
# Stream<[enum: [1, 2, 3], funs: [#Function<48.50989570/1 in Stream.map/2>]]>
# To make the iteration happen, we have to send the stream to an Enum function.

[9, -1, "foo", 25, 49] |>
  Stream.filter(&(is_number(&1) and &1 > 0)) |>
  Stream.map(&{&1, :math.sqrt(&1)}) |>
  Stream.with_index |>
  Enum.each(
    fn {{input, result}, index} ->
      IO.puts("#{index + 1}. sqrt(#{input}) = #{result}")
    end
  )

# stream relies on anonymous functions.

# In a nutshell
# To make a lazy computation, you need to return a lambda that performs the conputation.
# This makes the computation lazy because you return its description rather than the value from lambda.
# When the computation needs to be materialized, the comsummer code can call the lambda.