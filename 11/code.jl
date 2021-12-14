dt = (split.(readlines("11/data.txt"),"")) .|> x-> parse.(Int,x)
dt = permutedims(hcat(dt...))
nr,nc=size(dt)

function update!(m::Matrix)
    for i in 1:nr
        for j in 1:nc 
           m[i,j] += 1  
        end
    end
end
function flash!(m::Matrix)
    for i = 1:nr
        for j = 1:nc
            if m[i, j] > 9
                [try m[i+x, j+y] += 1 catch e end for x in adj, y in adj]
                m[i, j] = 0
                global totflashes += 1
            end
        end
    end
end

global adj = [-1,0,1]
global totflashes = 0

function step!(m::Matrix)
    update!(m)
    while maximum(m) > 9
        flash!(m)
    end
end

for _ in 1:100
    step!(dt)
end

totflashes

