require_relative '../app/model/robot'

class CommandExecutor
	EXECUTION_CODE = ['LEFT','RIGHT', 'MOVE', 'REPORT']
	def initialize(commands:, board:)
		@commands = commands
		@board = board
	end
	
	def run
		raise 'Board is not initialize' if board.nil? || board.class != Board

		(0...commands.count).each do |step_num|
			commands[step_num].each do |name, robot_command|
				robot = get_robot(name)
				case robot_command
				when *EXECUTION_CODE
					robot.action(robot_command, board)
				else
					place_robot(robot, robot_command)
				end
			end
		end
	end

	private
	attr_reader :commands, :board

	def place_robot(robot, coordinate)
		x, y, direction = coordinate.split(',')
	
		robot.x = x.to_i
		robot.y = y.to_i
		robot.direction = direction
	end

	def get_robot(name)
		robot = board.find_robot(name: name)
		
		if robot.nil?
			robot = Robot.new(name: name, max_board_size: board.size)
			board.add_robot(robot)
		end
		robot
	end
end