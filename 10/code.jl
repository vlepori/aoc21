global opening = ["(", "[", "{", "<"]
global closing = [")", "]", "}", ">"]
global defs = Dict(opening .=> closing)
global scores = Dict(closing .=> [3, 57, 1197, 25137])

function opposite(c)
    haskey(defs, c) && return defs[c]
    return missing
end

function iscorrupted(s::String)
    toclose = String[]
    for i = 1:length(s)
        str = string(s[i])
        if str in opening
            push!(toclose, opposite(str))
        elseif str in closing
            (str == toclose[end]) ? pop!(toclose) : return (str)
        end
    end
    out = length(toclose) == 0 ? ("sane") : ("incomplete")
    return out
end

dt = readlines("10/data.txt")
out = [iscorrupted(s) for s in dt]
sum(out[out.|>x->x in closing] .|> x -> scores[x])

# Part 2


function autocomplete(s)
    toclose = String[]
    for i in s
        # println(i)
        str = string(i)
        if str in opening
            push!(toclose, opposite(str))
        elseif str in closing
            (str == toclose[end]) ? pop!(toclose) : println("corrupt")
        end
    end
    return prod(toclose)
end

a = ((autocomplete(dt[4])))

global newscores = Dict(closing .=> [1, 2, 3, 4])

function score(s::String)
    tot = 0
    for c in s
        tot *= 5
        tot += newscores[string(c)]
    end
    return tot
end

score.(reverse.(autocomplete.(dt[out.=="incomplete"]))) |> sort |> x -> x[(length(x)÷2)+1]
