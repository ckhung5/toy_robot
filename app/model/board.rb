class Board

	SIZE = 6

	attr_reader :robots

	def initialize
		@width = SIZE
		@height = SIZE
		@robots = []
	end

	def add_robot(robot)
		@robots << robot
	end
end