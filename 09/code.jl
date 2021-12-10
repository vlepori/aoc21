dt = readlines("09/data.txt") |> x -> split.(x, "") |> y -> map(z -> parse.(Int, z), y) |> xx -> permutedims(hcat(xx...))
neighbors = [[0, 1], [0, -1], [1, 0], [-1, 0]]

islp(x, y, mat) = prod( [mat[x, y] < mat[x+i[1], y+i[2]] ? 1 : 0 for i in neighbors] )

padded = [(try dt[i, j] catch e 99 end) for i = 0:size(dt, 1)+1, j = 0:size(dt, 2)+1] 
lopts = [islp(x, y, padded) for x = 2:size(dt, 1)+1, y = 2:size(dt, 2)+1]
sum(dt[BitArray(lopts)] .+ 1)

## part II

using StatsBase

# random walk to find local minima
function walk(ix, iy, mat)
    init = [ix, iy]
    for _ = 1:1000
        cand = init + sample(neighbors)
        mat[cand...] < mat[init...] && (init = cand)
    end
    return init
end

out = [padded[i, j] == 9 ? [0, 0] : walk(i, j, padded) for i = 2:101, j = 2:101] # map of basins
sort([sum([i == j for j in vec(out)]) for i in unique(out)]) |> x->  prod(x[end-3:end-1]) # largest is 9s