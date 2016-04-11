require_relative "./city"
require_relative "./tour"
require_relative "./population"

class TSP
	attr_accessor :tour
	attr_accessor :population
	attr_accessor :optimal_route
	attr_accessor :optimal_route_distance

	SizeOfPopulation = 20
	NumberOfGeneration = 1000
	MutationRate = 0.7

	# cities is an array of [x, y] coordinates
	def initialize(cities)
		# convert cities into an array of City objects to create a tour
		@tour = Tour.new(cities)

		#puts "Tour distance is #{Tour.tour_distance(@tour.to_a)}"

		# generate a population based on the current tour
		@population = Population.new(@tour, SizeOfPopulation)

		@optimal_route_distance = 1000.00

		(0..NumberOfGeneration).each { | gencount |
			@population.compute_all_distances
			@population.find_best_tour
			
			new_best_distance = @population.best_tour_distance
			if (new_best_distance < @optimal_route_distance)
				# found a new best tour
				@optimal_route = @population.best_tour
				@optimal_route_distance = new_best_distance
			end

			# generate a new population using crossover
			new_pop = Population.new(nil, 0)

			until (new_pop.tour_list.length == SizeOfPopulation) do
				first_pos = rand(SizeOfPopulation - 1)
				second_pos = rand(SizeOfPopulation - 1)

				first_tour = @population.tour_list[first_pos]
				second_tour = @population.tour_list[second_pos]

				cross_tour = @population.crossover(first_tour, second_tour)

				if (rand > MutationRate)
					cross_tour = Tour.mutate_tour(cross_tour)
				end

				new_pop.add_tour(cross_tour)
			end

			# set this as the new population
			@population = new_pop
		}

#		puts "Final best route #{@optimal_route} - best distance #{@optimal_route_distance}"
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

tsp = TSP.new([[1, 2], [3, 4], [8, 7], [10, 12], [2, 4]])

puts "Best Route: #{tsp.route}"
puts "Best distance: #{tsp.dist} ==> #{tsp.dist.round(2)}"

