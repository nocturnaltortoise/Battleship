require "./Board"
require "./Board_Square"

class Battleship

  battleship = Battleship.new
	board = Board.new(10,10)
	tries = 0 #count the number of tries a user has had - i.e. total shots
	hit_count = { 
		carrier: 0,
		cruiser: 0,
		destroyer_one: 0,
		destroyer_two: 0,
		submarine: 0
	} #track the number of hits each ship has had
	all_ships_sunk = false

	board.make_board #initalize the board with default values
	board.add_ships #randomly place 5 ships



	def fire_shot(x,y,board,hit_count)
		#reveal the square the user fired at by setting the displayed contents to it's actual contents
		board.get_squares[x][y].set_displayed_contents(board.get_format(board.get_squares[x][y].get_contents))
    #set the square to revealed
		board.get_squares[x][y].set_revealed(true)
	
    #check if the current square contains a ship, add to hit count and output if the ship is sunk
		if board.get_squares[x][y].get_contents.is_a? Ship
			ship = board.get_squares[x][y].get_contents
			ship_name = ship.get_name

			hit_count[ship_name.to_sym] += 1
		
			if hit_count[ship_name.to_sym] >= ship.get_length
				formatted_ship_name = ship.format_name(ship_name.to_sym)
        ship.sink(true)
				puts "You sunk a #{formatted_ship_name}!"
			end
		end

	end
	
	def get_input
		puts "Enter target coordinates in the form x,y or x.y (e.g. 2,3 or 2.3): "
		target_coords = gets.chomp
    #split user input around the comma, turn both number strings into actual numbers
		target_coords.split(",")
		x = target_coords[0].to_i
		y = target_coords[2].to_i
		return x,y
	end

	def is_valid_input?(x, y, board)
    #check if the coordinates are within the baord, and that the square hasn't been revealed yet
		return (x <= 9 && x >= 1) && (y <= 9 && y >= 1) && (!board.get_squares[y][x].is_revealed?)
	end

  #loop until all ships are sunk, or something has broken and the user has tried every square and not managed to get all the ships somehow
	until all_ships_sunk || tries >= 81

    #all ships are sunk if all the ships have the sunk flag set
		all_ships_sunk = (board.get_ships[0].is_sunk?) && (board.get_ships[1].is_sunk?) && (board.get_ships[2].is_sunk?) && (board.get_ships[3].is_sunk?) && (board.get_ships[4].is_sunk?)

		board.render
		
		x,y = battleship.get_input
		
    #keep trying to get input until the user enters something sensible
		until battleship.is_valid_input?(x,y,board)
			puts "Enter a valid input (x,y)"
			x,y = battleship.get_input
		end
			
    #reveal the target square
		battleship.fire_shot(y, x, board, hit_count)
		tries += 1
	end

  #output score once game is over
	puts "Score: #{tries}"


end