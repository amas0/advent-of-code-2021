x = """7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7"""


struct BingoBoard
    board::Matrix{Int}
end

function string_to_board(input::AbstractString)::BingoBoard
    rows = split(input, '\n')
    ncols = length(split(rows[1]))
    nrows = length(rows)
    out = Matrix{Int}(undef, nrows, ncols)
    for (i, row) in enumerate(rows)
        out[i, :] = [parse(Int, d) for d in split(row)]
    end
    return BingoBoard(out)
end


function process_input(input::String)::Tuple{Vector{Int},Vector{BingoBoard}}
    draws, boards... = split(input, "\n\n")
    draws = [parse(Int, d) for d in split(draws, ',')]
    boards = [string_to_board(board) for board in boards]
    return (draws, boards)
end


function is_winner(board::BingoBoard, numbers::Vector{Int})::Bool
    nrow, ncol = size(board.board)
    marks = BitArray(undef, (nrow, ncol))
    for num in numbers
        indices = findall(n -> n == num, board.board)
        if !isempty(indices)
            index = indices[1]
            marks[index] = true
        end
    end
    for i in 1:nrow
        if sum(marks[i,:]) == ncol
            return true
        end
    end
    for i in 1:ncol
        if sum(marks[:,i]) == nrow
            return true
        end
    end
    return false
end


function board_score(board::BingoBoard, draws::Vector{Int})::Int
    nrow, ncol = size(board.board)
    marks = BitArray(undef, (nrow, ncol))
    for num in draws
        indices = findall(n -> n == num, board.board)
        if !isempty(indices)
            index = indices[1]
            marks[index] = true
        end
    end

    score = 0
    for i in 1:length(board.board)
        if !marks[i]
            score += board.board[i]
        end
    end
    return score*last(draws)
end


function one(input::AbstractString)::Int
    draws, boards = process_input(input)

    for n in 5:length(draws)
        for board in boards
            if is_winner(board, draws[1:n])
                return board_score(board, draws[1:n])
            end
        end
    end
end

function two(input::AbstractString)::Int
    draws, boards = process_input(input)
    won_boards = BitVector(undef, length(boards))

    for n in 5:length(draws)
        for (i, board) in enumerate(boards)
            if is_winner(board, draws[1:n]) && !won_boards[i]
                won_boards[i] = true
                if sum(won_boards) == length(boards)
                    return board_score(board, draws[1:n])
                end
            end
        end
    end
end


println(one(read("input_4.txt", String)))
println(two(read("input_4.txt", String)))