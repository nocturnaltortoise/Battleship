require "colorize"
require "./Ship"
require "./Board"

class Battleship

	battleships = Battleship.new

	board = Board.new(11,11)
	board.populate
	
	def update(board)
		if get_input[0..2] == "2,3"
			board.set_board_cell(2,3,true)
		else
			board.set_board_cell(2,3,false)
		end
	end

	def get_input
		puts "Enter a target cell: "
		user_target = gets.chomp
		user_target.split(",")
		return user_target
	end

	def render(board)
		board.grid_array.each do |row|
			row.each do |col|
				print "#{col} "
			end
			puts
		end
	end


	while true
		
		battleships.render(board)
		battleships.update(board)
	end

end