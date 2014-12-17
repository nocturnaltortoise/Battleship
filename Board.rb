require "./Board_Square"
require "./Ship"
require "colorize"

class Board

	def initialize(width, height)
		@WIDTH = width
		@HEIGHT = height
    #2d array of board squares
		@squares = Array.new(@WIDTH) { Array.new(@HEIGHT) }
    #array of ships, each with a length, name and state - whether they're sunk or not sunk
		@ships = [Ship.new(5,"carrier",false), Ship.new(4,"cruiser",false), Ship.new(3,"destroyer_one",false), Ship.new(3,"destroyer_two",false), Ship.new(2,"submarine",false)]
		#hash deals with the colorized output for ships (true) and water (false)
    @format = {
			true => " S ".colorize(:background => :red),
			false => " W ".colorize(:background => :blue)
		}
	end

  #evaluates a colorized output based on whether the square contains a ship
	def get_format(square)
		@format[square.is_a? Ship]
	end

	def get_squares
		@squares
	end

	def get_ships
		@ships
	end

	def make_board

		@squares.each_with_index do |row, row_count| 
			row.each_with_index do |col, col_count| 

				if(col_count == 0 && row_count == 0)
          #makes the corner square of the board a space
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, "   ", false)
				elsif(col_count == 0)
          #makes a column of numbers down the side, starting from 1 - square is not revealed, and defaults to false - i.e. not a ship
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " #{row_count} ", false)
				elsif(row_count == 0)
          #makes a row of numbers along the top, starting from 1 - square is not revealed, and defaults to false - i.e. not a ship
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " #{col_count} ", false)
				else
          #fills the rest of the board with default water squares, displayed as green question marks before they are revealed
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " ? ".colorize(:background => :green), false)
				end

			end
		end

	end

	def render
    #prints each square on the board
		@squares.each_with_index do |row, row_count|
			row.each_with_index do |col, col_count|
				@squares[row_count][col_count].print_square
			end
			puts
		end
	end
	
	def add_ships
		
		@ships.each_with_index do |ship, ship_number|
			
			ship_fits = false
			until ship_fits
        #generate random start point and direction (horizontal or vertical)
				start_x = rand(1..9)
				start_y = rand(1..9) 
				direction = rand(0..1) #0 = horizontal, 1 = vertical

        #makes sure the ship won't end up out of bounds
				if start_x + ship.get_length > 9
					next
				end

				if start_y + ship.get_length > 9
					next
				end


				#checks whether start point is already a ship, in which case, loop again
				next if @squares[start_x][start_y].get_contents.is_a? Ship
				
        #for each square of a particular ship length, check whether the next square is a ship, if so, loop again
				(0...ship.get_length).each do |ship_square|

					if direction == 1
						
						next if @squares[start_x + ship_square][start_y].get_contents.is_a? Ship

					else

						next if @squares[start_x][start_y + ship_square].get_contents.is_a? Ship

					end

				end

        #if all the previous ifs have not evaluated to true, then the ship will fit without overlapping, so set ship_fits to true to exit the loop
				ship_fits = true
			end

      #do the same loop, but set the contents of the squares within the ships to Ship objects, and set their name based on which ship in the array is being deployed
			(0...ship.get_length).each do |ship_square|

				if direction == 1
					@squares[start_x + ship_square][start_y].set_contents(ship)
          
					if ship_number == 0
						@squares[start_x + ship_square][start_y].get_contents.set_name("carrier")
					elsif ship_number == 1
						@squares[start_x + ship_square][start_y].get_contents.set_name("cruiser")
					elsif ship_number == 2
						@squares[start_x + ship_square][start_y].get_contents.set_name("destroyer_one")
					elsif ship_number == 3
						@squares[start_x + ship_square][start_y].get_contents.set_name("destroyer_two")
					else
						@squares[start_x + ship_square][start_y].get_contents.set_name("submarine")
					end
				else
					
					@squares[start_x][start_y + ship_square].set_contents(ship)

					if ship_number == 0
						@squares[start_x][start_y + ship_square].get_contents.set_name("carrier")
					elsif ship_number == 1
						@squares[start_x][start_y + ship_square].get_contents.set_name("cruiser")
					elsif ship_number == 2
						@squares[start_x][start_y + ship_square].get_contents.set_name("destroyer_one")
					elsif ship_number == 3
						@squares[start_x][start_y + ship_square].get_contents.set_name("destroyer_two")
					else
						@squares[start_x][start_y + ship_square].get_contents.set_name("submarine")
					end
				end

			end
			
		end

		
	end


end