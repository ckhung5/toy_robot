class Robot
	attr_reader :x, :y, :direction

	def initialize(x:, y:, direction:)
		@x = x
		@y = y
		@direction = direction
	end

	def report
		[x, y, direction]
	end
end