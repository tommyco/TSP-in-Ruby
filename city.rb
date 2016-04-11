class City
  attr_accessor :xpos
  attr_accessor :ypos

  # a city is defined by a X & Y coordinates
  def initialize(x, y)
    @xpos = x
    @ypos = y
  end

  # method to display the coordinates of a city
  def to_s
  	return "<#{@xpos}, #{@ypos}>"
  end

  # convert city object to an array
  def to_a
    return [@xpos, @ypos]
  end
end
