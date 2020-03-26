# frozen_string_literal: true

class Board
  SIZE = 6

  attr_reader :robots, :size

  def initialize
    @size = SIZE
    @robots = []
  end

  def add_robot(robot)
    return if find_robot(name: robot.name)

    @robots << robot
  end

  def existing_robot?(x:, y:)
    @robots.any? do |robot|
      robot.x == x && robot.y == y
    end
  end

  def find_robot(name:)
    @robots.detect do |robot|
      robot.name == name
    end
  end
end
