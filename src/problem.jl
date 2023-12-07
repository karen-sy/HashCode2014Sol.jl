using HashCode2014
include("functions.jl")
include("optimized.jl")

struct Problem
    problem::City
    solution::Solution
    distance::Int
    Problem(duration::Int) = begin
        problem = change_duration(city(), duration)
        solution = optimal_walk(problem)
        distance = get_soln_distance(solution, problem)
        return new(problem, solution, distance)
    end 
end 