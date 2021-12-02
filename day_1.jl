function get_input(path::String)::String
    file = open(path, "r")
    s = read(file, String)
    close(file)
    return s
end

function process_input(x::String)::Vector{Int}
    return [parse(Int, num) for num in split(x, "\n") if num != ""]
end

function count_increases(x::Vector{Int})::Int
    is_increase = [d > 0 for d in diff(x)]
    return sum(is_increase)
end

function rolling_sum(x::Vector{Int}, window::Int=3)::Vector{Int}
    sums = zeros(Int, length(x) - window + 1)
    for i in range(window, stop=length(x))
        sums[i-(window - 1)] = sum(x[i-window+1:i])
    end
    return sums
end


"input_1_1.txt" |> get_input |> process_input |> count_increases |> print
print("\n")
"input_1_1.txt" |> get_input |> process_input |> rolling_sum |> count_increases |> print 