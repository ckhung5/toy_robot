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

  def unavailable_to_operate
    [x, y, direction, @max_board_size, name].any?(nil)
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

  def report
    p [name, x, y, direction&.upcase]
  end

  def turn_left
    return if unavailable_to_operate
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
    return if unavailable_to_operate
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

  def move(board)
    cal_x = x
    cal_y = y
    return if unavailable_to_operate
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
    return if board.existing_robot?(x: cal_x, y: cal_y)
    @x = cal_x
    @y = cal_y
  end
end
