DEMO_INPUT_1 = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""

function parse_input(str)
    lines = split(str, "\n")
    lines = [line for line in lines if line != ""]
    lines = [parse.(Int, split(line)) for line in lines]
    return lines
end

function is_safe(level::Vector{Int})
    diffs = diff(level)
    return all(1 .<= diffs .<= 3) || all(-3 .<= diffs .<= -1)
end

function n_safe(ipt)
    return sum(is_safe.(ipt))
end

function test_1()
    ipt = parse_input(DEMO_INPUT_1)
    n_save_levels = n_safe(ipt)
    @assert n_save_levels == 2
end

function is_safe_with_damper(level::Vector{Int})
    is_safe(level) && return true
    for (i, _) in enumerate(level)
        candidate = copy(level)
        deleteat!(candidate, i)
        is_safe(candidate) && return true
    end
    return false
end

function n_safe_with_damper(ipt)
    return sum(is_safe_with_damper.(ipt))
end

function test_2()
    ipt = parse_input(DEMO_INPUT_1)
    n_save_levels = n_safe_with_damper(ipt)
    @assert n_save_levels == 4
end

function main()
    test_1()
    test_2()
    input = open("data/2.txt") do f
        read(f, String)
    end
    ipt = parse_input(input)
    solution_1 = n_safe(ipt)
    println(solution_1)
    solution_2 = n_safe_with_damper(ipt)
    println(solution_2)
end

main()