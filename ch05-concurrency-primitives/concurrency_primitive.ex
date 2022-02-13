run_query = fn query_def -> 
  Process.sleep(2000)
  "#{query_def} result"
end

spawn(fn -> IO.puts(run_query.("query 1")) end)