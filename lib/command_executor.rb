require_relative '../app/model/robot'

class CommandExecutor
	EXECUTION_CODE = ['LEFT','RIGHT', 'MOVE', 'REPORT']
	def initialize(commands:, board:)
		@commands = commands
		@board = board
	end
	
	def run
		raise 'Board is not initialize' if board.nil? || board.class != Board
		commands.each do |name, command_list|
			robot = board.find_robot(name: name)

			command_list.each do |robot_command|
				case EXECUTION_CODE.any?(robot_command)
				when true
					raise 'Robot is not initilise properly to do command' if robot.nil? || robot.unavailable_to_operate
					robot.action(robot_command)
				when false
					x, y, direction = robot_command.split(',')

					raise "Could not place new robot on position x:#{x}, y:#{y} as there is an existing one" if validate_spot_before_place(board, x.to_i, y.to_i)
					robot = Robot.new(name: name, max_board_size: board.size)
					robot.x = x.to_i
					robot.y = y.to_i
					robot.direction = direction
					board.add_robot(robot)
				end
			end
		end
	end

	private
	attr_reader :commands, :board

	def validate_spot_before_place(board, x, y)
		board.exisiting_robot?(x: x, y: y)
	end
end