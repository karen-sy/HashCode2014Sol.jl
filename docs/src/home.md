# Home

## Background
City is defined as a graph with nodes called junctions, connected by edges called streets. Junctions have defined lat. and long. coordinates, while streets have two junctional endpoints a and b; streets are also indicated bidirectionality, as well as by distance and time to travel across the street by car.   

The problem at hand is to optimize Google Streetview collections. We ideally must travel along as many unique streets as possible. We are constrained by various factors:
1. nb_cars = number of cars 
2. total_duration = total duration, in seconds, the nb_cars have to traverse all the streets 
3. starting_junction = the street corner in which all cars start their walks along 

A random_walk solution, in the starter code, randomly, for each car, chooses a viable street to travel across. Our task for the challenge is to reduce computation time, and increase total distance traveled across the city. 

## Quickstart
```@contents
Pages = [
    "tutorial.md",
]
Depth = 3
```

## Functions
```@index
Pages = ["index.md"]
Depth = 3
```

## Algorithm description
```@contents
Pages = [
    "algo.md",
]
Depth = 3
```