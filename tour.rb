require_relative "./city"

class Tour
	attr_accessor :aTour

    # given a list of cities, construct a new tour
	def initialize(cities)
		@aTour = []
		cities.each {|x, y| @aTour << City.new(x, y)}
	end

	# method to display all the cities in the current tour
	def to_s
		puts @aTour.each {|aCity| aCity }
	end

    # reshuffle the cities in the current tour
	def shuffle
		@aTour.shuffle
	end

    # return the content of the tour as an array of cities
    def to_a
    	@aTour
    end

    # define the origin city
    def self.set_origin_city(origin_city)
        @@origin_city = origin_city
    end

    # compute the distance between 2 cities
    def self.node_distance(from_city, to_city)
    	xdis = from_city.xpos - to_city.xpos
    	ydis = from_city.ypos - to_city.ypos

    	return Math.sqrt(xdis ** 2 + ydis ** 2)
    end

    # compute the total distance of a tour
    def self.tour_distance(oneTour)
    	tour_length = oneTour.length
    	if tour_length > 0
    		total = Tour.node_distance(@@origin_city, oneTour[0])
    	end
    	(0..(tour_length-2)).each do |n| 
    		total += Tour.node_distance(oneTour[n], oneTour[n+1])
    	end
    	if tour_length > 0
    		total += Tour.node_distance(oneTour[tour_length - 1], @@origin_city)
    	end
    	return total
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