class Ship

	def initialize(length, name, is_sunk)
		@length = length
		@name = name
		@format = {
			carrier: "Carrier",
			cruiser: "Cruiser",
			destroyer_one: "Destroyer",
			destroyer_two: "Destroyer",
			submarine: "Submarine"
		}
		@is_sunk = is_sunk
	end

	def sink(is_sunk)
		@is_sunk = is_sunk
	end

	def is_sunk?
		@is_sunk
	end

	def format_name(key)
		@format[key]
	end

	def get_length
		@length
	end

	def get_name
		@name
	end

	def set_name(name)
		@name = name
	end

end