# Read in data
dt = Vector{String}[]
for ln in readlines("12/data.txt")
    from, to = split(ln, "-")
    push!(dt, [from, to])
    push!(dt, [to, from])
end
nodes = vcat(vcat(dt...)...)

# Make Dict of links
links = Dict{String,Vector{String}}()
for node in unique(nodes)
    to = []
    for i in dt
        if i[1] == node
            push!(to, i[2])
        end
    end
    push!(links, node => to)
end

"generate all possible paths of length l+1"
function generate(path::Vector{String}, d::Dict)
    out = Vector{String}[]
    [push!(out, (push!(deepcopy(path), i))) for i in d[path[end]]]
    return out
end

nonunique(x::Vector) = [sum(x .== i) > 1 ? i : 0 for i in x] |> y -> unique(y[y.!==0])
issmall(cave::String) = islowercase(cave[1])

function isvalid(path::Vector{String})::Bool
    path[1] == "start" || return false
    any(issmall.(nonunique(path))) && return false
    return true
end

function isfinished(path::Vector{String})::Bool
    path[1] == "start" || return false
    path[end] == "end" || return false
    return true
end

function findpaths(links, steps)
    currentpaths = [["start"]]
    finished = Vector{String}[]

    for _ = 1:steps
        tentative = vcat([generate(p, links) for p in currentpaths]...)
        valid = tentative[isvalid.(tentative)]
        currentpaths = unique(valid)
        f = currentpaths[isfinished.(currentpaths)]
        finished = unique(vcat(finished, f))
    end

    return finished
end

out = findpaths(links, 20)

## Part II: will melt your CPU

# morethantwice(x::Vector) = [sum(x .== i) > 2 ? i : 0 for i in x] |> y -> unique(y[y.!==0])
# function isvalid2(path::Vector{String})::Bool
#     path[1] == "start" || return false
#     any(issmall.(morethantwice(path))) && return false
#     "start" in nonunique(path) && return false
#     "end" in nonunique(path) && return false
#     return true
# end
# function findpaths2(links, steps)
#     currentpaths = [["start"]]
#     finished = Vector{String}[]
#     for _ = 1:steps
#         tentative = vcat([generate(p, links) for p in currentpaths]...)
#         valid = tentative[isvalid2.(tentative)]
#         currentpaths = unique(valid)
#         f = currentpaths[isfinished.(currentpaths)]
#         finished = unique(vcat(finished, f))
#     end
#     return finished
# end
# out = findpaths2(links, 20)