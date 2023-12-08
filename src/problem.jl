using HashCode2014
include("functions.jl")
include("optimized.jl")

"""
    Problem

Store a Problem that stores a custom default city from HashCode2014 as `problem`, only modifying it by the
`duration` given at construction, as well as its most optimal walk `solution` and the unique `distance`
traveled in this `solution` in meters.

# Fields
- `problem::City`: a problem city description
- `solution:Solution`: a solution to the `problem` based on the `optimal_walk` algorithm 
- `distance::Int`: a record, in meters, of the unique distance traveled by the cars in optimal `solution`

    Problem(duration::Int)

# Constructor
- Returns a Problem instance about a default city with the given `duration` (in seconds)
"""
struct Problem
    problem::City
    solution::Solution
    distance::Int
    Problem(duration::Int) = begin
        problem = change_duration(city(), duration)
        solution = optimal_walk(problem)
        distance = distance(solution, problem)
        return new(problem, solution, distance)
    end 
end 