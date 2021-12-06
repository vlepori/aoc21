# Day 6
mutable struct Fish
    state::Int
end
mutable struct School
    fishes::Vector{Fish}
end
School(v::Vector{Int}) = School([Fish(i) for i in v])

function day!(s::School)
    for f in s.fishes
        if f.state > 0
            f.state -= 1
        else
            f.state = 6
            push!(s.fishes,Fish(9))
        end
    end
end

lanterns = School(parse.(Int,split(readline("06/data.txt"),",")))
for _ in 1:80
    day!(lanterns)
end
length(lanterns.fishes)

# Part II - previous method is computationally inefficient given exponential increase

ages = collect(0:8)
structure = [sum(i .== data) for i in ages]

for _ in 1:256
    old = deepcopy(structure)
    for i in 1:8
        structure[i] = old[i+1]
    end
    structure[7] += old[1]
    structure[9] = old[1]
end

sum(structure)