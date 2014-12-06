grid_array = Array.new(10) { Array.new(9, " ") }

def render_grid(grid_array)

	row_count = 0
	col_count = 1

	grid_array.each do |row|
		
		print row_count

		row.each do |col|

			if row_count == 0
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

	input_coords = user_input.split

	return input_coords

end

puts "Choose your target coordinates (e.g. 2 3)"
input = gets.chomp

get_input(input)

render_grid(grid_array)