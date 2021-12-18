x = "3,4,3,1,2"

const Lanternfish = Int8
const MAX_FISH_AGE = 7


function input_to_fish(input::AbstractString)::Vector{Lanternfish}
    return [parse(Int8, s) for s in split(input, ',')]
end

function new_day(fish::Vector{Lanternfish})::Vector{Lanternfish}
    new_fish = similar(fish)
    for (i, e) in enumerate(fish)
        if e > 0
            new_fish[i] = e - 1
        else
            new_fish[i] = MAX_FISH_AGE - 1
            push!(new_fish, MAX_FISH_AGE + 1)
        end
    end
    return new_fish
end

function one(input::AbstractString, num_days::Int = 80)::Int
    fish = input_to_fish(input)
    day = 0
    while day < num_days
        fish = new_day(fish)
        day += 1
    end
    return length(fish)
end

function two(input::AbstractString, num_days::Int = 256)::Int
    counter = zeros(Int, MAX_FISH_AGE + 2)
    for f in input_to_fish(input)
        counter[f+1] += 1
    end
    day = 0
    while day < num_days
        new_counter = similar(counter)
        new_counter[1:MAX_FISH_AGE + 1] = counter[2:MAX_FISH_AGE + 2]
        new_counter[MAX_FISH_AGE + 2] = counter[1]
        new_counter[MAX_FISH_AGE] += counter[1]
        counter = new_counter
        day += 1
    end
    return sum(counter)
end


println(one(read("input_6.txt", String)))
println(two(read("input_6.txt", String)))