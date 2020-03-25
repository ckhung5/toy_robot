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

  def action(command)
    case command
    when 'LEFT'
      turn_left
    when 'RIGHT'
      turn_right
    when 'MOVE'
      move
    when 'REPORT'
      report
    end
  end

  private

  def report
    p [name, x, y, direction.upcase]
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
      @x -= 1 unless x - 1 < 0
    end
  end
end
