# Part 1

mutable struct Submarine
    hposition::Int
    depth::Int
end

forward!(s::Submarine, d::Int) = s.hposition += d
up!(s::Submarine, d::Int) = s.depth -= d
down!(s::Submarine, d::Int) = s.depth += d

thesub = Submarine(0, 0)

for cmd in readlines("02/data.txt")
    mv, dist = split(cmd, " ")
    eval(Meta.parse("$(mv)!(thesub,$dist)"))
end

thesub |> s -> s.hposition * s.depth

# Part 2 (restart julia first)

mutable struct Submarine
    hposition::Int
    depth::Int
    aim::Int
end

function forward!(s::Submarine, d::Int)
    s.hposition += d
    s.depth += s.aim * d
end

up!(s::Submarine, d::Int) = s.aim -= d
down!(s::Submarine, d::Int) = s.aim += d

thesub = Submarine(0, 0, 0)

for cmd in readlines("02/data.txt")
    mv, dist = split(cmd, " ")
    eval(Meta.parse("$(mv)!(thesub,$dist)"))
end

thesub |> s -> s.hposition * s.depth