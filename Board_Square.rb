class Board_Square

	def initialize(x_coord,y_coord,contents, displayed_contents, revealed)
		@x_coord = x_coord
		@y_coord = y_coord
		@contents = contents
		@displayed_contents = displayed_contents
		@revealed = revealed
	end

	def set_revealed(revealed)
		@revealed = revealed
	end

	def is_revealed?
		@revealed
	end

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