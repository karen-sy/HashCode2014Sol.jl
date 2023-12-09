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

For a city with a feasible `solution`, returns the unique distance traveled by the cars 
"""
function distance(solution::Solution, city::City)
    return HashCode2014.total_distance(solution, city)
end

"""
    random_walk_distance()

Performs a random walk on the default `city()` and returns the unique distance traveled by the cars 
"""
function random_walk_distance()
    c = HashCode2014.read_city()
    solution = HashCode2014.random_walk(c)
    return HashCode2014.total_distance(solution, c)
end 

"""
    upper_limit(city)

Takes a city and gives an approximate upper limit on the distance that can be feasibly traveled by the cars 
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
