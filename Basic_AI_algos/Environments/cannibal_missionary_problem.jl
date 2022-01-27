"""
Problem Statement:
In the rabbit leap problem, three east-bound rabbits stand in a line blocked by three west-bound rabbits. 
They are crossing a stream with stones placed in the east west direction in a line. 
There is one empty stone between them. 
The rabbits can only move forward one or two steps. 
They can jump over one rabbit if the need arises, but not more than that. 
Are they smart enough to cross each other without having to step into the water? 

While there can be many possible algos to resolve this tiny problem, 
we shall start with just uninformed agents like bfs and dfs.
"""


"""
A basic setup of a state would be something like,
leftside: no of cannibals, no of missionaries
rightside: no of cannibals, no of missionaries
boat position: right or left

By reducing redundant fields, we can just represent the state with 3 fields.
Hence, I created the state like "m c b"
where,
m => no of missionaries
c => no of cannibals
b => boat(0 for left, 1 for right)
"""

initial_state = "330" # initially all missionaries and cannibals are on left side
target_state = "001" # at the end they all are at right side(as well as boat)

function all_moves(m, c, b)
    if b == '0'
        return [
            [m-1, c],
            [m-2, c],
            [m, c-1],
            [m, c-2],
            [m-1, c-1]
        ]
    else
        return [
            [m+1, c],
            [m+2, c],
            [m, c+1],
            [m, c+2],
            [m+1, c+1]
        ]
    end
end

function is_valid_move(missionary, cannibal)
    # removing bad cases given
    if missionary > 3 || cannibal > 3 || missionary < 0 || cannibal < 0
        return false
    end
    # if all missionaries on one side, they are always safe
    if missionary == 0 || missionary == 3
        return true
    end
    # making sure that missionaries are more than or equal cannibals on both sides
    return missionary >= cannibal && (3 - missionary) >= (3 - cannibal)
end

function possible_moves(state)
    m, c, b = state
    moves = filter(p->is_valid_move(parse(Int,p[1]), parse(Int, p[2])), all_moves(m,c,b))
    new_boat = b == '1' ? '0' : '1'
    return map(p->join([p[1], p[2], new_boat]), moves)
end