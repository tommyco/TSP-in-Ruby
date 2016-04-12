require_relative "./city"
require_relative "./tour"
require_relative "./population"

class GA
	MutationRate = 0.7
	TournamentSize = 5

    def self.evolve(population)
    	population.compute_all_distances
    	population.find_best_tour

        # always enable elitism by saving best tour as the first new tour
    	new_pop = Population.new(nil, 0)
    	new_pop.add_tour(population.best_tour)

    	until (new_pop.size == population.size) do
    		tour1 = tournamentSelection(population)
    		tour2 = tournamentSelection(population)

    		cross_tour = crossover(tour1, tour2)
    		if (rand > MutationRate)
				cross_tour = Tour.mutate_tour(cross_tour)
			end
    		new_pop.add_tour(cross_tour)
    	end
    	return new_pop
    end

	def self.tournamentSelection(population)
		# generate a new tournament population
		# by randomly selecting from the input population
		tournament_pop = Population.new(nil, 0)
		until (tournament_pop.size == TournamentSize) do
			pindex = rand(population.size)
			tournament_pop.add_tour(population.tour_list[pindex])
		end

		tournament_pop.compute_all_distances
		tournament_pop.find_best_tour
		return tournament_pop.best_tour
	end

    # single point crossover of 2 tours
    # extract a random number of cities from the first tour
    # then append the content of the second tour in order but not including the cities already in the newly generated tour
    def self.crossover(tour1, tour2)
 	   rpos= rand(tour1.length)
	   child_tour = tour1.take(rpos)
	   child_tour.concat(tour2.reject { | city_elem | child_tour.include? city_elem  })
    end

    # point mutation of the current tour
	def self.mutate_tour(oneTour)
		randpos1 = rand(oneTour.length - 1)
		randpos2 = rand(oneTour.length - 1)
		if (randpos1 != randpos2)
			temp_city = oneTour[randpos1]
			oneTour[randpos1] = oneTour[randpos2]
			oneTour[randpos2] = temp_city
		end
		return oneTour
	end

end
