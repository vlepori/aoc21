# DAY 1

# part 1
parse.(Int, readlines("01/data.txt")) |> x -> sum(diff(x) .> 0)

# part 2
parse.(Int, readlines("01/data.txt")) |> dt -> [sum(dt[i:i+2]) for i = 1:length(dt)-2] |> x -> sum(diff(x) .> 0) 