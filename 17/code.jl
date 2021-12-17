mutable struct Probe
    position::Vector{Int}
    velocity::Vector{Int}
end

function move_step!(p::Probe)
    p.position += p.velocity
    p.velocity[1] -= sign(p.velocity[1])
    p.velocity[2] -= 1
end

between(x, v) = (x >= v[1]) & (x <= v[2])
hits(pos, target) = between(pos[1], target[1]) & between(pos[2], target[2])

function launch(probe::Probe, target)
    vinit = deepcopy(probe.velocity)
    hmax = probe.position[2]
    while probe.position[2] >= target[2][1]
        move_step!(probe)
        hmax = max(hmax, probe.position[2])
        hits(probe.position, target) && return [hmax, 1, vinit[1], vinit[2]]
    end
    return [hmax, 0, vinit[1], vinit[2]]
end

target = [[240, 292], [-90, -57]]
out = vec([launch(Probe([0, 0], [vx, vy]), target) for vx = 1:500, vy = -500:500]) |> y -> y[y .|> x -> x[2] == 1] 
maximum(first.(out))

# Part II
length(out)

