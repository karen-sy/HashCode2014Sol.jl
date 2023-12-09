# Welcome to the Documentation for HashCode2014Sol.jl

## Background
The problem at hand is to optimize Google Streetview collections. We ideally must travel along as many unique streets as possible. 

A `City` is a graph with nodes (`Junction`s), connected by edges (`Street`s). Junctions have defined latitude and longitude coordinates, and streets have two junctional endpoints ("a" and "b"). Streets are also indicated bidirectionality, as well as by distance and time required to travel across the street by car.   

We are constrained by various factors:
1. `nb_cars` = number of cars 
2. `total_duration` = total duration, in seconds, the nb_cars have to traverse all the streets 
3. `starting_junction` = the street corner in which all cars start their walks along 

A `random_walk` solution, in the starter code, randomly, for each car, chooses a viable street to travel across. Our task for the challenge is to reduce computation time, and increase total distance traveled across the city. 

See the Quickstart page for instructions on running the code.

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