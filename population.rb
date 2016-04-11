class Population
   attr_accessor :tour_list
   attr_accessor :tour_distances

   attr_accessor :best_tour
   attr_accessor :best_tour_distance

   # given a tour, generate a list of (unique) tours by random shuffling
   # generate the requested number of tours
   def initialize(tour, size)
   	  @tour_list = []
   	  if (size > 0)
   	  	# save the tour passed in as the first tour
   	  	@tour_list << tour.to_a
      	until (@tour_list.length == size) do
	      	newTour = tour.shuffle
  		  	@tour_list << newTour unless @tour_list.detect {| tour_elem | tour_elem == newTour }
      	end
      end
   end

   def add_tour(newTour)
   	 @tour_list << newTour.to_a unless @tour_list.detect {| tour_elem | tour_elem == newTour }
   end

   # compute the total distances of all the tours in the population
   def compute_all_distances
   	  @tour_distances = []
   	  @tour_list.each { | aTour | @tour_distances << Tour.tour_distance(aTour) }
   end

   # find the tour with the least distance
   def find_best_tour
	  min_index= tour_distances.index { | dist | dist == tour_distances.min }

	  @best_tour = tour_list[min_index]
	  @best_tour_distance = tour_distances[min_index]
   end

   # single point crossover of 2 tours
   # extract a random number of cities from the first tour
   # then append the content of the second tour in order but not including the cities already in the newly generated tour
   def crossover(tour1, tour2)
 	  rpos= rand(tour1.length)
	  child_tour = tour1.take(rpos)
	  child_tour.concat(tour2.reject { | city_elem | child_tour.include? city_elem  })
   end
end