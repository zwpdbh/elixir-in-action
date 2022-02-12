# Perform nested itermations over multple collections. 
for x <- [1, 2, 3], y<-[1, 2, 3], do: {x, y, x*y}
# [
#   {1, 1, 1},
#   {1, 2, 2},
#   {1, 3, 3},
#   {2, 1, 2},
#   {2, 2, 4},
#   {2, 3, 6},
#   {3, 1, 3},
#   {3, 2, 6},
#   {3, 3, 9}
# ]

# Use "into" option to specify what to collect
# create a multplication table
multiplication_table = 
for x <- 1..9, y <- 1..9, into: %{} do
    {{x, y}, x * y}
end

multiplication_list = 
for x <- 1..3, y <- 1..3, into: [] do
    [[x, y, x*y]]
end