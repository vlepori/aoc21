dt = readlines("08/data.txt") .|> x-> (split(x," | "))[2] |> y->split.(y, " ")

sum([sum([length(x) in [2,3,4,7] for x in d]) for d in dt])