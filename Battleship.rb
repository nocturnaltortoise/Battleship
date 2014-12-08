require "colorize"

grid_array = Array.new(10) { Array.new(10, " ") }

#need to have a method to populate the grid first, and then a method to render it
def render_grid(grid_array)

	row_count = 0
	col_count = 0

	grid_array.each do |row|
		
		print row_count

		row.each do |col|

			if row_count == 0

				if col_count==0
					print " "
				end
				print "#{col_count}"
				col_count += 1

			else
				print col
			end
		end

		row_count += 1
		puts

	end

end

def get_input(user_input)

	input_coords = user_input.split(",")

	return input_coords

end

def add_ships
end

def is_ship?
end

def update(coords, grid_array)

	grid_array[coords[1].to_i][coords[0].to_i - 1] = "x".colorize(:background => :blue)

end

while true
	puts "Choose your target coordinates (e.g. 2,3)"
	input = gets.chomp

	update(get_input(input),grid_array)

	render_grid(grid_array)
end