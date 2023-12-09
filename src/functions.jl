using HashCode2014

"""
    city()

Allows user to create a default HashCode2014 city 
# Parameter: none 
Returns default city of type City in HashCode2014 starter 
"""
function city()
    return HashCode2014.read_city()
end 

"""
    change_duration(city, total_duration)
Create a new City with a different `total_duration` and everything else equal.
# Parameter
- `city::City` - city whose duration we would like to change 
- `total_duration::Int` - the new `total_duration` (in meters) we would like to change to 
Returns a new City instance that changes the `total_duration` to that specified
"""
function change_duration(city::City, total_duration::Int)
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

For a city with a feasible `solution`, find the distance traveled in the solution 
# Parameter
- `solution::Solution` - a feasibility itinerary solution to the junctions the cars travel to 
- `city::City` - city whose data values derive the solution
Returns an int representing the unique distance traveled by the cars in the `solution` in meters
"""
function distance(solution::Solution, city::City)
    return HashCode2014.total_distance(solution, city)
end

"""
    random_walk_distance()

Performs a random walk on the default `city()` and gets the distance
# Parameter: none
Returns an int representing the unique distance traveled by the cars in the `solution` in meters
"""
function random_walk_distance()
    c = HashCode2014.read_city()
    solution = HashCode2014.random_walk(c)
    return HashCode2014.total_distance(solution, c)
end 
    
"""
    get_neighbor_streets(city)

Compute a matrix calculating all the streets travelable from `junctions` in `city`
# Parameter
- `city::City`: City instance for which we want to map neighboring streets for for each street
# Returns
- Returns a vector `neighbors_streets`, such that for every junction with index i: every junction index in `neighbors_streets[i]` can be traveled to from junction i
- More specificically: that if street in `neighbors_streets[i]`: `street.endpointA = i`
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

Calculate an approximate upper limit on the distance travelable in `city`
# Parameter
- `city::City`: target City instance 
Returns an integer, in meters, representing the upper limit travelable by cars in `city`

Algorithm in documentation 
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