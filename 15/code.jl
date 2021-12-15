dt = (split.(readlines("15/data.txt"),"")) .|> x-> parse.(Int,x)
dt = permutedims(hcat(dt...))
costmap = fill(99999, size(dt,1), size(dt,2))
costmap[1,1] = 0

global neighbors = [[0, 1], [0, -1], [1, 0], [-1, 0]]
minneighbor(mat::Matrix, coord) = minimum([try mat[(coord + n)...] catch e Inf end for n in neighbors])
flood(cmap,hmap) = [min(cmap[i,j], hmap[i,j] + minneighbor(cmap,[i,j])) for i in 1:size(cmap,1), j in 1:size(cmap,2)]

function findpath(cmap,hmap)
    stable = false
    while !stable
        ncmap = flood(cmap,hmap)
        stable = cmap == ncmap
        cmap = ncmap
    end
    return cmap
end
findpath(costmap,dt)[end,end]