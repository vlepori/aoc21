using Statistics
dt = parse.(Int, split(readline("07/data.txt"), ","))
med = Int(median(dt))
sum([abs(d - med) for d in dt])
# minimum([sum([abs(d - p) for d in dt]) for p in (:)(extrema(dt)...)])

# Part 2
cost(a, b) = sum(1:abs(a - b))
minimum([sum([cost(d, p) for d in dt]) for p in (:)(extrema(dt)...)])
