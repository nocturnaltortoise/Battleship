require "./Board_Square"
require "./Ship"
require "colorize"

class Board

	def initialize(width, height)
		@WIDTH = width
		@HEIGHT = height
		@squares = Array.new(@WIDTH) { Array.new(@HEIGHT) }
		@ships = [Ship.new(5,"carrier",false), Ship.new(4,"cruiser",false), Ship.new(3,"destroyer_one",false), Ship.new(3,"destroyer_two",false), Ship.new(2,"submarine",false)]
		@format = {
			true => " S ".colorize(:background => :red),
			false => " W ".colorize(:background => :blue)
		}
	end

	def get_format(key)
		@format[key.is_a? Ship]
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
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, "   ", false)
				elsif(col_count == 0)
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " #{row_count} ", false)
				elsif(row_count == 0)
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " #{col_count} ", false)
				else
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " ? ".colorize(:background => :green), false)
				end

			end
		end

	end

	def render
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

				start_x = rand(1..9)
				start_y = rand(1..9) 
				direction = rand(0..1)

				if start_x + ship.get_length > 9
					next
				end

				if start_y + ship.get_length > 9
					next
				end

				puts @squares[start_x][start_y].get_contents.is_a? Ship
				if @squares[start_x][start_y].get_contents.is_a? Ship
					next
				end
				
				(0...ship.get_length).each do |ship_square|

					if direction == 1
						
						next if @squares[start_x + ship_square][start_y].get_contents.is_a? Ship

					else

						next if @squares[start_x][start_y + ship_square].get_contents.is_a? Ship

					end

				end

				ship_fits = true
			end

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