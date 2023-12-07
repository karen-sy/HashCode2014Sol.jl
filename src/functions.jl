using HashCode2014

"""
    city()
Returns default city of type City in HashCode2014 starter 
"""
function city()
    return HashCode2014.read_city()
end 

"""
    change_duration(city, total_duration)

Create a new City with a different `total_duration` and everything else equal.
"""
function change_duration(city::City, total_duration)
    new_city = City(;
        total_duration=total_duration,
        nb_cars=city.nb_cars,
        starting_junction=city.starting_junction,
        junctions=copy(city.junctions),
        streets=copy(city.streets),
    )
    return new_city
end

function solution(city::HashCode2014.City)
    return HashCode2014.random_walk(city)
end 

function distance(solution, city)
    return HashCode2014.total_distance(solution, city)
end

function random_walk_distance()
    c = HashCode2014.read_city()
    solution = HashCode2014.random_walk(c)
    return HashCode2014.total_distance(solution, c)
end 

function get_soln_distance(solution::Solution, c::City)
    return HashCode2014.total_distance(solution, c)
end 
    
"""
    city: city for which we want to map neighboring streets for for each street
    returns a vector neighbors_streets, such that for every junction with index i: every junction index
        in neighbors_streets[i] can be traveled to from junction i
        Goes even more specific that if street in neighbors_streets[i]:
                street.endpointA = i 
"""
function get_neighbor_streets(city::HashCode2014.City)
    streets = city.streets
    junctions = city.junctions
    N = length(junctions) #number of nodes 
    neighbors_streets = [Vector{HashCode2014.Street}() for _ in 1:N]
    #neighbors_streets[i] represents the corresponding streets that travel them from junction i 
    #to its neighbors 

    for street in streets
        i = street.endpointA
        j = street.endpointB

        push!(neighbors_streets[i], street)
        if street.bidirectional
            push!(neighbors_streets[j], Street(j, i, true, street.duration, street.distance))
        end 
    end 
    return neighbors_streets
end 