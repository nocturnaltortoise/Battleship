require "./Board_Square"
require "./Ship"
require "colorize"

class Board

	def initialize(width, height)
		@WIDTH = width
		@HEIGHT = height
		@squares = Array.new(@WIDTH) { Array.new(@HEIGHT) }
		@ships = [Ship.new(5,"carrier"), Ship.new(4,"cruiser"), Ship.new(3,"destroyer_one"), Ship.new(3,"destroyer_two"), Ship.new(2,"submarine")]
		@format = {
			true => " S ".colorize(:background => :red),
			false => " W ".colorize(:background => :blue)
		}
	end

	def get_format(key)
		@format[key]
	end

	def get_squares
		@squares
	end

	def make_board

		@squares.each_with_index do |row, row_count| 
			row.each_with_index do |col, col_count| 
				if(col_count == 0 && row_count == 0)
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, "   ")
				elsif(col_count == 0)
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " #{row_count} ")
				elsif(row_count == 0)
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " #{col_count} ")
				else
					@squares[row_count][col_count] = Board_Square.new(row_count, col_count, false, " ? ".colorize(:background => :green))
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

		@ships.each do |ship|

			start_x = rand(1..9)
			start_y = rand(1..9)
			direction = rand(0..3)


			if start_x + ship.get_length > 9
				start_x = start_x - ship.get_length
			elsif start_x - ship.get_length < 1
				start_x = start_x + ship.get_length
			end

			if start_y + ship.get_length > 9
				start_y = start_y - ship.get_length
			elsif start_y - ship.get_length < 1
				start_y = start_y + ship.get_length
			end
				
			# until start_x + ship.get_length < 9 && start_x + ship.get_length > 1
			# 	puts "failed to position ships"
			# end

			# until start_y + ship.get_length < 9 && start_y + ship.get_length > 1
			# 	puts "failed to position ships"
			# end

			count = 1

			# while start_x + ship.get_length > @WIDTH || start_x - ship.get_length < 1 || start_y + ship.get_length > @HEIGHT || start_y - ship.get_length < 1
				
			# end

			@squares[start_x][start_y].set_contents(true)

			while count < ship.get_length

				if start_x + count > 9 || start_x - count < 1
					break
				end

				if start_y + count > 9 || start_y - count - ship.get_length < 1
					break
				end

				if direction == 0
					
					if @squares[start_x][start_y+count].get_contents
						add_ships
					else
						@squares[start_x][start_y+count].set_contents(true)
					end
				elsif direction == 1

					if @squares[start_x+count][start_y].get_contents
						add_ships
					else
						@squares[start_x+count][start_y].set_contents(true)
					end
				elsif direction == 2

					if @squares[start_x][start_y-count].get_contents
						add_ships
					else
						@squares[start_x][start_y-count].set_contents(true)
					end
				elsif direction == 3

					if @squares[start_x-count][start_y].get_contents
						add_ships
					else
						@squares[start_x-count][start_y].set_contents(true)
					end
				end	
				count += 1
			end

		end


	end


end