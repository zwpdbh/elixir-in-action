defmodule PM do
  def match_tuples do 
    # The return value will be the right-side term matching agaist if everyting is fine.
    {name, age} = {"Bob", 25} 
  end
  
  def area({:rectangle, a, b}) do
    a * b
  end
  
  def area({:square, a}) do
    a * a
  end
  
  def area({:circle, r}) do
    r * r * 3.14
  end
  
  def area(unknown) do
    {:error, {:unknown_shape, unknown}}
  end
  
  defmodule TestNum do
    def test(x) when is_number(x) and x < 0 do
      :negative
    end
    
    def test(0) do
      :zero
    end
    
    def test(x) when is_number(x) and x > 0 do
      :positive
    end    
  end    
end

# iex(34)> PM.area({:rectangle, 4, 5})
# PM.area({:rectangle, 4, 5})
# 20
# iex(35)> PM.area({:circle, 10})
# PM.area({:circle, 10})
# 314.0
# iex(36)> PM.area({:square, 11})
# PM.area({:square, 11})
# 121

# fun = &PM.area/1
# fun.({:circle, 4})
# fun.({:circle, 4})
# 50.24

# fun.({:square, 4})
# fun.({:square, 4})
# 16

# fun.({:square, 4, 5})
# fun.({:square, 4, 5})
# {:error, {:unknown_shape, {:square, 4, 5}}}



# iex(43)> TestNum.test(-1)
# TestNum.test(-1)
# :negative
# iex(44)> TestNum.test(0)
# TestNum.test(0)
# :zero




defmodule Polymorphic do
  def double(x) when  is_number(x) do
    2 * x
  end
  def double(x) when is_binary(x) do
    x <> x
  end
end

# iex(5)> Polymorphic.double(3)
# Polymorphic.double(3)
# 6
# iex(6)> Polymorphic.double("zw")
# Polymorphic.double("zw")
# "zwzw"

# pattern mathching in function is very useful to define recursive method
defmodule Fact do
  def fact(0) do
    1
  end
  def fact(n) do
    n * fact(n-1)
  end
end


# == Sometimes, it is more useful to create classic branch construct 
# =if=
# if condition do
#   ...
# else  
#   ...
# end

# =if inline 
# if condition, do: something, else: another thing
if 5 < 4 do
  :one
else 
  :two 
end

if 5 < 3, do: :one, else: :two




# === use with to chain multiple pattern matching
defmodule ChainPattern do
  # define some helper function
  def extract_login(%{"login" => login}) do
    {:ok, login}
  end
  def extract_login(_) do
    {:error, "login missed"}
  end

  def extract_email(%{"email" => email}) do
    {:ok, email}
  end
  def extract_email(_) do
    {:error, "email missed"}
  end

  def extract_password(%{"password" => password}) do
    {:ok, password}
  end
  def extract_password(_) do
    {:error, "password missed"}
  end


  def extract_info(submitted) do
    with {:ok, login} <-extract_login(submitted),
      {:ok, email} <-extract_email(submitted),
      {:ok, password} <-extract_password(submitted) do
      {:ok, %{login: login, email: email, password: password}}
    end
  end
end

submitted = %{
  "login" => "alice",
  "email" => "some_email",
  "password" => "password",
  "other_field" => "some_value",
  "yet_another_not_wanted_field" => "..."
}

# iex(20)> ChainPattern.extract_info(submitted)
# ChainPattern.extract_info(submitted)
# {:ok, %{email: "some_email", login: "alice", password: "password"}}



# Tail recursive
# a non tail-recursive one 
defmodule ListHelper do
  def sum([]) do
    0
  end
  def sum([head | tail]) do
    head + sum(tail)
  end
end