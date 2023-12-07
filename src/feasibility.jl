using HashCode2014
include("problem.jl")

function robust_is_feasible(problem::Problem)
    if(!is_feasible(problem.solution, problem.problem)) return false end 
end