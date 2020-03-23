class Robot
	attr_reader :x, :y, :direction

	def initialize(x:, y:, direction:, max_board_size:)
		@x = x
		@y = y
		@direction = direction
		@max_board_size = max_board_size
	end

	def report
		[x, y, direction.upcase]
	end

	def turn_left
		@direction = case direction.downcase
		when 'north'
			'west'
		when 'south'
			'east'
		when 'east'
			'north'
		when 'west'
			'south'
		end
	end

	def turn_right
		@direction = case direction.downcase
		when 'north'
			'east'
		when 'south'
			'west'
		when 'east'
			'south'
		when 'west'
			'north'
		end
	end

	def move
		case direction.downcase
		when 'north'
			@y += 1 unless y + 1 > @max_board_size
		when 'south'
			@y -= 1 unless y - 1 < 0
		when 'east'
			@x += 1 unless x + 1 > @max_board_size
		when 'west'
			@x -= 1	unless x - 1 < 0
		end
	end
end