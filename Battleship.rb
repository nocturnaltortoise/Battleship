require "./Board"
require "./Board_Square"

class Battleship

	board = Board.new(10,10)
	battleship = Battleship.new
	tries = 0

	def initialize
		
	end

	hit_count = { 
		carrier: 0,
		cruiser: 0,
		destroyer_one: 0,
		destroyer_two: 0,
		submarine: 0
	}



	def fire_shot(x,y,board,hit_count)
		#this works for displaying output, but a shot fired needs to hit a ship, not *just* display a truth value
		board.get_squares[x][y].set_displayed_contents(board.get_format(board.get_squares[x][y].get_contents))
		puts board.get_squares[x][y].get_contents
		
		if board.get_squares[x][y].get_contents.is_a? Ship
			ship_name = board.get_squares[x][y].get_contents.get_name
			hit_count[ship_name.to_sym] += 1
			
			if hit_count[ship_name.to_sym] >= board.get_squares[x][y].get_contents.get_length
				formatted_ship_name = board.get_squares[x][y].get_contents.format_name(ship_name.to_sym)
				puts "You sunk a #{formatted_ship_name}!"
			end

		end

	end
	
	def get_input
		puts "Enter target coordinates in the form x,y (e.g. 2,3): "
		target_coords = gets.chomp
		target_coords.split(",")
		x = target_coords[0].to_i
		y = target_coords[2].to_i
		return x,y
	end

	def is_valid_input?(x, y)
		(x <= 9 && x >= 1) && (y <= 9 && y >= 1)
	end

	board.make_board
	board.add_ships
	
	while true
		board.render
		
		x,y = battleship.get_input
		
		# puts target_coords[0].is_a?(Integer)
		# puts target_coords[1].is_a?(Integer)
		
		until battleship.is_valid_input?(x,y)
			puts "Enter a valid input (x,y)"
			x,y = battleship.get_input
		end
			
		battleship.fire_shot(y, x, board, hit_count)
		tries += 1
		puts "Score: #{tries}"
		
			
	
	end


end