dt = readlines("04/data.txt")
input = parse.(Int, split(dt[1], ","))
dt = dt[2:end]

function totable(strvec)
    vv = split.(strvec[2:end], " ", keepempty = false) .|> x -> parse.(Int, x)
    permutedims(hcat(vv...))
end

boards = [totable(dt[i:i+5]) for i = 1:6:595]

isin(mat,vec)::BitMatrix = [mat[i,j] in vec for i in 1:size(mat,1), j in 1:size(mat,2)]
checkboard(b::BitMatrix) = sum(([sum(prod(b, dims = i)) for i = 1:2]))

for i = 1:length(input)
    for b in boards
        if checkboard(isin(b, input[1:i])) !== 0
            error( input[1:i][end] * sum(b[.!isin(b, input[1:i])]))
        end
    end
end