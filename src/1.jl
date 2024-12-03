DEMO_INPUT = "3   4
4   3
2   5
1   3
3   9
3   3"

function parse_input(str)
    lines = split(str, "\n")
    lines = [line for line in lines if line != ""]
    lines = [parse.(Int, split(line)) for line in lines]
    list1 = [line[1] for line in lines]
    list2 = [line[2] for line in lines]
    return list1, list2
end

function distance(list1, list2)

    n = length(list1)
    @assert n == length(list2)

    list1_sorted = sort(list1)
    list2_sorted = sort(list2)

    paired_dists = map(1:n) do i
        a = list1_sorted[i]
        b = list2_sorted[i]
        abs(a - b)
    end
    return sum(paired_dists)
end

function test_1()
    list1, list2 = parse_input(DEMO_INPUT)
    dist = distance(list1, list2)
    @assert dist == 11
end

function similarity(list1, list2)

    n = length(list1)
    @assert n == length(list2)

    scores = map(1:n) do i
        a = list1[i]
        b = sum(list2 .== a)
        a * b
    end
    return sum(scores)
end

function test_2()
    list1, list2 = parse_input(DEMO_INPUT)
    score = similarity(list1, list2)
    @assert score == 31
end

function main()
    test_1()
    test_2()
    input_1 = open("data/1.txt") do f
        read(f, String)
    end
    list1, list2 = parse_input(input_1)
    dist = distance(list1, list2)
    println(dist)
end

main()
