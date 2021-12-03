mutable struct Position
    horizontal::Int
    depth::Int
end

@enum Direction forward up down

struct Instruction
    directon::Direction
    distance::Int
end

function process_input(lines::Vector{String})::Vector{Instruction}
    instructions = similar(lines, Instruction)
    for i in eachindex(lines)
        token, dist = split(lines[i], ' ')
        if token == "forward"
            instructions[i] = Instruction(forward, parse(Int, dist))
        elseif token == "up"
            instructions[i] = Instruction(up, parse(Int, dist))
        else
            instructions[i] = Instruction(down, parse(Int, dist))
        end
    end
    return instructions
end

function move_sub(curr::Position, instr::Instruction)
    if instr.directon == forward
        curr.horizontal += instr.distance
    elseif instr.directon == up
        curr.depth -= instr.distance
    else
        curr.depth += instr.distance
    end
end


sub = Position(0, 0)
instructions = (process_input ∘ readlines)("input_2_1.txt")
for instr in instructions
    move_sub(sub, instr)
end

print(sub.depth * sub.horizontal)