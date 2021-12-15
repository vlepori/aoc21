dt=readlines("13/data.txt")
brk = findall(dt.=="")[1]
paper = dt[1:brk-1] |> x->split.(x,",")  .|> y-> parse.(Int,y)
instructions = dt[brk+1:end]

nr,nc = [maximum(paper .|> x-> x[i]) for i in 1:2]
mat = zeros(Int, nr+1,nc+1)
[mat[i+1,j+1] = 1 for (i,j) in paper]

rev_left(m) = [m[i,size(m,2)-j+1] for i in 1:size(m,1), j in 1:size(m,2)]
rev_up(m) = [m[size(m,1)-i+1,j] for i in 1:size(m,1), j in 1:size(m,2)]

# 'at' is in base-0 !
function fold_up(mat::Matrix,at::Int)
    keep = mat[1:at,:]
    paste = rev_up(mat[at+2:end,:])
    keep[end-size(paste,1)+1 : end, :] += paste
    return keep
end

function fold_left(mat::Matrix,at::Int)
    keep = mat[:,1:at]
    paste = rev_left(mat[:,at+2:end])
    keep[:,end-size(paste,2)+1 : end] += paste
    return keep
end
sum(fold_up(mat,655).> 0  )

# Part 2
for ln in (instructions)
    dir, mag = split(split(ln,"along ")[2],"=")  
    mat = dir == "x" ? fold_up(mat,parse(Int,mag)) : fold_left(mat,parse(Int,mag))
end
permutedims(mat .|> x-> x == 0 ? '.' : 'X')

# 6×40 Matrix{Char}:
#  'X'  'X'  'X'  '.'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  'X'  'X'  'X'  '.'  'X'  'X'  'X'  'X'  '.'  '.'  'X'  'X'  '.'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  'X'  'X'  '.'  '.'
#  'X'  '.'  '.'  'X'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  '.'  '.'  '.'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'
#  'X'  '.'  '.'  'X'  '.'  'X'  'X'  '.'  '.'  '.'  'X'  'X'  'X'  'X'  '.'  'X'  'X'  'X'  '.'  '.'  '.'  '.'  'X'  '.'  '.'  'X'  '.'  '.'  '.'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  'X'  'X'  '.'  '.'
#  'X'  'X'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  '.'  '.'  '.'  'X'  '.'  '.'  '.'  'X'  '.'  'X'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'
#  'X'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  '.'  '.'  'X'  '.'  '.'  '.'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'
#  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  'X'  '.'  'X'  '.'  '.'  '.'  '.'  'X'  'X'  'X'  'X'  '.'  '.'  'X'  'X'  'X'  '.'  '.'  'X'  'X'  '.'  '.'  'X'  'X'  'X'  '.'  '.'