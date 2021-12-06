format(s::String) = parse.(Int, vcat(split.(split(s, " -> "), ",")...))
dt = permutedims(hcat((readlines("05/data.txt") .|> format)...))

uc(x) = unique(collect(x))
ir(v::Vector) = minimum(v):maximum(v)

function coords(x, y)
    xbigger = length(x) > length(y)
    long = xbigger ? x : y
    short = xbigger ? y : x

    if xbigger
        return hcat(fill(short[1], length(long)), long)
    else
        return hcat(long, fill(short[1], length(long)))
    end
end

function addvent!(fl::Matrix, row)
    crds = coords(uc(ir(row[[1, 3]])), uc(ir(row[[2, 4]])))
    for r in eachrow(crds)
        fl[r[1], r[2]] += 1
    end
end

seafloor = fill(0, maximum(dt), maximum(dt))

for i in 1:size(dt,1)
    dr = dt[i,:]
    if (dr[1] == dr[3]) | (dr[2] == dr[4])
         addvent!(seafloor, dr)
    end
end

sum(seafloor .> 1)


