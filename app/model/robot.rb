# frozen_string_literal: true

class Robot
  attr_accessor :name, :x, :y, :direction

  def initialize(name: nil, x: nil, y: nil, direction: nil, max_board_size: nil)
    @name = name
    @x = x
    @y = y
    @direction = direction
    @max_board_size = max_board_size
  end

  def action(command, board)
    case command
    when 'LEFT'
      turn_left
    when 'RIGHT'
      turn_right
    when 'MOVE'
      move(board)
    when 'REPORT'
      report
    end
  end

  private

  def unavailable_to_operate
    [x, y, direction, @max_board_size, name].any?(nil)
  end

  def report
    p "#{name}: #{x},#{y},#{direction&.upcase}"
  end

  def turn_left
    return if unavailable_to_operate

    @direction = direction_calculator(-1)
  end

  def turn_right
    return if unavailable_to_operate

    @direction = direction_calculator(+1)
  end

  def direction_calculator(increment_or_decrement)
    directions = %w[north east south west]

    direction_index = directions.find_index(direction.downcase)

    if direction_index + increment_or_decrement < 0
      directions[3]
    elsif direction_index + increment_or_decrement > directions.length
      directions[0]
    else
      directions[direction_index + increment_or_decrement]
    end
  end

  def move(board)
    return if unavailable_to_operate

    new_x_position, new_y_position = position_calculator
    return if board.existing_robot?(x: new_x_position, y: new_y_position)

    @x = new_x_position
    @y = new_y_position
  end

  def position_calculator # rubocop:disable Metrics/MethodLength
    cal_x = x
    cal_y = y
    case direction.downcase
    when 'north'
      cal_y += 1 unless cal_y + 1 > @max_board_size
    when 'south'
      cal_y -= 1 unless cal_y - 1 < 0
    when 'east'
      cal_x += 1 unless cal_x + 1 > @max_board_size
    when 'west'
      cal_x -= 1 unless cal_x - 1 < 0
    end
    [cal_x, cal_y]
  end
end
