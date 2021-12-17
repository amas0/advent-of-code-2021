x = """00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010"""

function to_array(input::String)::BitArray{2}
    n_lines = count('\n', input) + 1
    n_col = findfirst('\n', input) - 1
    out = BitArray(undef, (n_col, n_lines))
    nospaces = replace(input, "\n" => "")
    for i in eachindex(out)
        is_1 = nospaces[i] == '1'
        out[i] = is_1
    end
    return permutedims(out, (2, 1))
end

function to_int(bv::BitVector)::Int
    return sum([b*(2^(length(bv)-i)) for (i, b) in enumerate(bv)])
end

function calc_gamma_rate(array::BitArray{2})::Int
    n_row, n_col = size(array)
    gamma_rate_binary = BitArray(undef, n_col)
    for i in 1:n_col
        gamma_rate_binary[i] = 2*sum(array[:,i]) >= n_row
    end
    return to_int(gamma_rate_binary)
end

function calc_epsilon_rate(array::BitArray{2})::Int
    n_row, n_col = size(array)
    epsilon_rate_binary = BitArray(undef, n_col)
    for i in 1:n_col
        epsilon_rate_binary[i] = 2*sum(array[:,i]) < n_row
    end
    return to_int(epsilon_rate_binary)
end

function most_common_bit(v::BitVector)::Bool
    return 2*sum(v) >= length(v)
end

function oxygen_generator_rating(array::BitArray{2})::Int
    n_row, n_col = size(array)
    arr = array
    curr_bit = 1
    while size(arr, 1) > 1
        cb = most_common_bit(arr[:,curr_bit])
        num_filtered_rows = sum(arr[:,curr_bit] .== cb)
        new_arr = BitArray(undef, (num_filtered_rows, n_col))
        j = 1
        for i in 1:size(arr, 1)
            if arr[i,curr_bit] == cb
                new_arr[j,:] = arr[i,:]
                j += 1
            end
        end
        arr = new_arr
        curr_bit += 1
    end
    return to_int(arr[1,:])
end

function co2_scrubber_rating(array::BitArray{2})::Int
    n_row, n_col = size(array)
    arr = array
    curr_bit = 1
    while size(arr, 1) > 1
        lcb = !most_common_bit(arr[:,curr_bit])
        num_filtered_rows = sum(arr[:,curr_bit] .== lcb)
        new_arr = BitArray(undef, (num_filtered_rows, n_col))
        j = 1
        for i in 1:size(arr, 1)
            if arr[i,curr_bit] == lcb
                new_arr[j,:] = arr[i,:]
                j += 1
            end
        end
        arr = new_arr
        curr_bit += 1
    end
    return to_int(arr[1,:])
end


one(string) = to_array(string) |> arr -> calc_gamma_rate(arr)*calc_epsilon_rate(arr)
two(string) = to_array(string) |> arr -> oxygen_generator_rating(arr)*co2_scrubber_rating(arr)

println(one(read("input_3_1.txt", String)))
println(two(read("input_3_1.txt", String)))
