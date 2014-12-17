class Board_Square

	def initialize(x_coord,y_coord,contents, displayed_contents, revealed)
		@x_coord = x_coord
		@y_coord = y_coord
    #contents contains the actual contents of a square - water or ship (true for ship, false for water)
		@contents = contents
    #displayed contents is the default display for the square (to hide the actual contents) - e.g. ? for the main grid squares
		@displayed_contents = displayed_contents
    #whether the square has been targeted already
		@revealed = revealed
	end

	def set_revealed(revealed)
		@revealed = revealed
	end

	def is_revealed?
		@revealed
	end

  #prints the initially visible contents
	def print_square
		print "#{@displayed_contents}"
	end

	def get_contents
		@contents
	end

	def get_displayed_contents
		@displayed_contents
	end

	def set_displayed_contents(displayed_contents)
		@displayed_contents = displayed_contents
	end

	def set_contents(contents)
		@contents = contents
	end

end