require "./Board"
require "./Board_Square"

class Battleship

	board = Board.new(10,10)
	battleship = Battleship.new
	hit_count = 0

	def fire_shot(x,y,board)
		#this works for displaying output, but a shot fired needs to hit a ship, not *just* display a truth value
		board.get_squares[y][x].set_displayed_contents(board.get_format(board.get_squares[y][x].get_contents))

	end
	
	def get_input
		puts "Enter target coordinates in the form x,y (e.g. 2,3): "
		target_coords = gets.chomp
	end
	
	board.make_board
	board.add_ships

	while true
		board.render
		target_coords = battleship.get_input.split(",")
		battleship.fire_shot((target_coords.first).to_i, (target_coords.last).to_i, board)
	end


end