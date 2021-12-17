dt = (split.(readlines("15/data.txt"), "")) .|> x -> parse.(Int, x)
dt = permutedims(hcat(dt...))
costmap = fill(99999, size(dt))
costmap[1, 1] = 0

global neighbors = [[0, 1], [0, -1], [1, 0], [-1, 0]]
minneighbor(mat::Matrix, coord) = minimum([try  mat[(coord + n)...] catch e Inf end for n in neighbors ])
flood(cmap, hmap) = [min(cmap[i, j], hmap[i, j] + minneighbor(cmap, [i, j])) for i = 1:size(cmap, 1), j = 1:size(cmap, 2)]

function findpath(cmap, hmap)
    stable = false
    while !stable
        ncmap = flood(cmap, hmap)
        stable = cmap == ncmap
        cmap = ncmap
    end
    return cmap
end

findpath(costmap, dt)[end, end]

# Part II
dt2 = vcat([hcat([dt .+ i for i = 0:4]...) .+ j for j in 0:4]...)
dt2[dt2 .> 9] .-= 9
cm2 = fill(Inf,size(dt2))
cm2[1,1] = 0
sol=findpath(cm2,dt2)