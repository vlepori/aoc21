# part 1

dt = readlines("03/data.txt") |> x -> split.(x, "") .|> x -> parse.(Int, x)
sums = [sum([dt[i][j] for i = 1:1000]) for j = 1:length(dt[1])]
γr = Int.(round.(sums ./ 1000))
ϵr = γr .|> x -> x == 1 ? 0 : 1

# Ha there must be a better way...binary to decimal
function bintodec(s::String)
    sp = parse.(Int, split(s, ""))
    bs = reverse([2^i for i = 0:length(sp)-1])
    sum(bs .* sp)
end

bintodec(join(γr)) * bintodec(join(ϵr)) 