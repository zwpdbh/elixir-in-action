      
defmodule Calculator do
  defp loop(current_value) do
    new_value =
      receive do 
        {:value, caller} -> 
          send(caller, {:response, current_value})
          current_value 
        {:add, value}  -> current_value + value
                
      end
  end
end

      