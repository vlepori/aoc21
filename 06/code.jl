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

dt = parse.(Int,split(readline("06/data.txt"),","))
str = [sum(i .== dt) for i in 0:8]
for _ in 1:256
    zero = str[1]
    for i in 1:8
        str[i] = str[i+1]
    end
    str[7] += zero
    str[9] = zero
end
sum(str)

# alternative with Leslie matrix approach:

dt = parse.(Int,split(readline("06/data.txt"),","))
str = [sum(i .== dt) for i in 0:8]
leslie = [i==j-1 ? 1 : 0 for i=0:8,j=0:8]
leslie[7,1] = 1
leslie[9,1] = 1
for _ in 1:256
    str = leslie * str
end
sum(str)