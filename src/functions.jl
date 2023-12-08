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

"""
    distance(solution, city)
For a city with a feasible solution, returns the unique distance traveled by the cars 
"""
function distance(solution::Solution, city::City)
    return HashCode2014.total_distance(solution, city)
end

"""
    random_walk_distance()
Performs a random walk on the default city() and returns the unique distance traveled by the cars 
"""
function random_walk_distance()
    c = HashCode2014.read_city()
    solution = HashCode2014.random_walk(c)
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

"""
    upper_limit(city)
Takes a city and gives an approximate upper limit on the distance that can be feasibly traveled by the cars 
Algorithmic description:
    Assumes that all streets are travelable from one another, and that it is actually one car traveling for a limit
    total of total_duration*nb_cars seconds. In that case, we can greedily assume that this one car travels along 
    only the most "efficient" streets, or streets that maximize the meter distance traveled per second.
    We sort the streets by this efficiency definition and make the car travel along the most efficient, making sure
    it does not exceed (total_duration*nb_cars), and keeping track of the total distance being traveled.
    At the end, we return this final distance. 
"""
function upper_limit(city::HashCode2014.City)
    (; total_duration, nb_cars, starting_junction, streets) = city

    # sorts by "most efficient" streets, distance per time unit 
    sorted = sort!(streets, by=street->(street.distance)/(street.duration), rev=true)
    duration = 0
    distance = 0
    while length(sorted) > 0 
        street = popfirst!(sorted)
        if(street.duration+duration > (total_duration*nb_cars)) #check if next streets are better 
            continue end 
        duration += street.duration
        distance += street.distance
    end 
    return distance
end 