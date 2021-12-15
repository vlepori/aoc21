import StatsBase as SB
start,rules = readlines("14/data.txt") |> x-> [x[1],x[3:end]]
rulesdict = split.(rules, " -> ") |> y -> [y .|> x-> x[i] for i in 1:2] |> z-> Dict(z[1] .=> z[2])

insert(s::String,idx::Int,c::String) = split(s,"") |> x-> insert!(x,idx,c) |> join
function step(s,dict)
    old = deepcopy(s)
    for i in 1:length(old)-1 
        s = insert(s,2i,dict[s[2i-1:2i]])  
    end
    return s
end

function polymerize(str,steps::Int)
    for _ in 1:steps
        str = step(str,rulesdict)
    end
    return str
end

out=polymerize(start,10);
SB.countmap(out) |> values |> extrema |> x-> maximum(x)-minimum(x)
