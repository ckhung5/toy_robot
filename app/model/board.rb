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

	def exisiting_robot?(x:, y:)
		@robots.any? do |robot|
			robot.x == x && robot.y == y
		end
	end
end