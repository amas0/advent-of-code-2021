function read_input(input::AbstractString)::Vector{Int}
    return [parse(Int, s) for s in split(input, ',')]
end


function median(v::Vector{Int})::Int
    sorted = sort(v)
    l = length(v)
    if isodd(l)
        pos = (l + 1) ÷ 2
        return sorted[pos]
    else
        pos = l ÷ 2
        return Int(round(sum(sorted[pos:pos+1]) / 2))
    end
end


function one(input::Vector{Int})::Int
    med = median(input)
    return sum([abs(x - med) for x in input])
end

function cost(a::Int, b::Int)::Int
    d = abs(b - a)
    return d*(d+1) ÷ 2
end

function total_cost(v::Vector{Int}, target::Int)::Int
    return sum([cost(u, target) for u in v])
end

function two(input::Vector{Int})::Int
    mn, mx = minimum(input), maximum(input)
    min_fuel = total_cost(input, mn)
    for target in mn+1:mx
        c = total_cost(input, target)
        if c < min_fuel
            min_fuel = c
        end
    end
    return min_fuel
end


x = "16,1,2,0,4,2,7,1,2,14"
y = read_input(x)


input = read_input(read("input_7.txt", String))

println(one(input))
println(two(input))