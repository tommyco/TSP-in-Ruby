require_relative "./city"
require_relative "./tour"
require_relative "./population"
require_relative "./ga"

class TSP
	attr_accessor :tour
	attr_accessor :population
	attr_accessor :optimal_route
	attr_accessor :optimal_route_distance

	SizeOfPopulation = 50
	NumberOfGeneration = 100
	MutationRate = 0.7

	# cities is an array of [x, y] coordinates
	def initialize(cities)
		# define the origin city
		origin_city = City.new(0, 0)	
		Tour.set_origin_city(origin_city)	

		# convert cities into an array of City objects to create a tour
		@tour = Tour.new(cities)

        puts "Tour is #{@tour}"
		puts "Initial Tour Distance = #{Tour.tour_distance(@tour.to_a)}"

		# generate a population based on the current tour
		@population = Population.new(@tour, SizeOfPopulation)

		(0..NumberOfGeneration).each { | gencount |
			@population = GA.evolve(@population)
		}

		@population.compute_all_distances
    	@population.find_best_tour

    	@optimal_route = @population.best_tour
		@optimal_route_distance = @population.best_tour_distance

		puts "Final best route #{@optimal_route} - best distance #{@optimal_route_distance}"
	end

    # return the optimal route found so far
    # convert cities to array
	def route
		best_route = []
		@optimal_route.each { | city | best_route << city.to_a }
		return best_route
	end

	# return the distance of the best optimal route found so far
	def dist
		return @optimal_route_distance
	end
end

# tsp = TSP.new([[1,1], [8,4], [10, 11], [4, 5], [3,3], [5,6], [3,2]])

# puts "Best Route: #{tsp.route}"
# puts "Best distance: #{tsp.dist} ==> #{tsp.dist.round(2)}"

