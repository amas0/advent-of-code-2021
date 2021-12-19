struct Point
    x::Int
    y::Int
end

const Line = Vector{Point}
const CoverageMap = Matrix{Int}


function endpoint_to_line(a::Point,b::Point)::Line
    dx = b.x - a.x
    dy = b.y - a.y
    if (dx == 0) || (dy == 0)
        if dx != 0
            return [Point(x, a.y) for x in min(a.x,b.x):max(a.x,b.x)]
        elseif dy != 0
            return [Point(a.x, y) for y in min(a.y,b.y):max(a.y,b.y)]
        end
    end
end

function input_to_lines(input::AbstractString)::Vector{Line}
    lines = split(input, '\n')
    output = Vector{Line}()
    for (i, line) in enumerate(lines)
        a, b = split(line, " -> ")
        a = [parse(Int, s) for s in split(a, ',')]
        b = [parse(Int, s) for s in split(b, ',')]
        a = Point(a[1], a[2])
        b = Point(b[1], b[2])
        if (a.x == b.x) || (a.y == b.y)
            push!(output, endpoint_to_line(a, b))
        end
    end
    return output
end

function coverage_map(lines::Vector{Line})::CoverageMap
    max_x, max_y = 0, 0
    for line in lines
        max_x_line = maximum([p.x for p in line])
        max_y_line = maximum([p.y for p in line])
        if max_x_line > max_x
            max_x = max_x_line
        end
        if max_y_line > max_y
            max_y = max_y_line
        end
    end

    map = zeros(Int, max_y+1, max_x+1)
    for line in lines
        if (first(line).x == last(line).x) || (first(line).y == last(line).y)
            for point in line
                map[point.y+1, point.x+1] += 1
            end
        end
    end
    return map
end


function one(input::AbstractString)::Int
    cov_map = coverage_map(input_to_lines(input))
    count = 0
    for e in cov_map
        if e >= 2
            count += 1
        end
    end
    return count
end

function endpoint_to_line_2(a::Point,b::Point)::Line
    dx = b.x - a.x
    dy = b.y - a.y
    if (dx == 0) || (dy == 0)
        if dx != 0
            return [Point(x, a.y) for x in min(a.x,b.x):max(a.x,b.x)]
        elseif dy != 0
            return [Point(a.x, y) for y in min(a.y,b.y):max(a.y,b.y)]
        end
    else
        sx = sign(dx)
        sy = sign(dy)
        steps = abs(dx)
        return [Point(a.x + sx*step, a.y + sy*step) for step in 0:steps]
    end
end

function input_to_lines_2(input::AbstractString)::Vector{Line}
    lines = split(input, '\n')
    output = Vector{Line}()
    for (i, line) in enumerate(lines)
        a, b = split(line, " -> ")
        a = [parse(Int, s) for s in split(a, ',')]
        b = [parse(Int, s) for s in split(b, ',')]
        a = Point(a[1], a[2])
        b = Point(b[1], b[2])
        push!(output, endpoint_to_line_2(a, b))
    end
    return output
end

function coverage_map_2(lines::Vector{Line})::CoverageMap
    max_x, max_y = 0, 0
    for line in lines
        max_x_line = maximum([p.x for p in line])
        max_y_line = maximum([p.y for p in line])
        if max_x_line > max_x
            max_x = max_x_line
        end
        if max_y_line > max_y
            max_y = max_y_line
        end
    end

    map = zeros(Int, max_y+1, max_x+1)
    for line in lines
        for point in line
            map[point.y+1, point.x+1] += 1
        end
    end
    return map
end

function two(input::AbstractString)::Int
    cov_map = coverage_map_2(input_to_lines_2(input))
    count = 0
    for e in cov_map
        if e >= 2
            count += 1
        end
    end
    return count
end

x = """0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"""

println(one(read("input_5.txt", String)))
println(two(read("input_5.txt", String)))
