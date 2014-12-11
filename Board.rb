class Board

	def initialize(width, height)
		@WIDTH = width
		@HEIGHT = height
		@grid_array = Array.new(@WIDTH) { Array.new(@HEIGHT, "-") }
	end

	def grid_array
		@grid_array
	end

	def populate
		row_count = 0
		col_count = 0

		@grid_array.each do |row|

			row.each do |col|

				if row_count == 0
					if col_count == 0
						@grid_array[row_count][col_count] = " "
					else
						@grid_array[row_count][col_count] = col_count - 1
					end
				elsif col_count == 0
					@grid_array[row_count][col_count] = row_count - 1
				end

				col_count += 1

			end

			col_count = 0
			row_count += 1
		end
	end	

	def set_board_cell(x, y, ship)
		if ship
			@grid_array[y + 1][x + 1] = "x"
		else
			@grid_array[y + 1][x + 1] = "o"
		end
	end

end