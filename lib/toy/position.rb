require_relative 'formatter/printable'

module Toy
  class Position
    DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

    attr_reader :x, :y, :direction

    include Toy::Formatter::Printable

    def initialize(x:, y:, direction:)
      raise ArgumentError, 'Invalid position' unless x.is_a?(Integer) && y.is_a?(Integer)
      raise ArgumentError, 'Invalid direction' unless DIRECTIONS.include?(direction)

      @x = x
      @y = y
      @direction = direction
    end

    def move
      new_x, new_y =
        case @direction
        when 'NORTH' # up
          [@x, @y + 1]
        when 'EAST' # right
          [@x + 1, @y]
        when 'SOUTH' # down
          [@x, @y - 1]
        when 'WEST' # left
          [@x - 1, @y]
        end

      Position.new(x: new_x, y: new_y, direction: @direction)
    end

    def left
      new_direction = DIRECTIONS[(DIRECTIONS.index(@direction) - 1) % 4]
      Position.new(x: @x, y: @y, direction: new_direction)
    end

    def right
      new_direction = DIRECTIONS[(DIRECTIONS.index(@direction) + 1) % 4]
      Position.new(x: @x, y: @y, direction: new_direction)
    end

    def ==(other)
      x == other.x && y == other.y && direction == other.direction
    end

    def pretty_print
      "#{@x},#{@y},#{@direction}"
    end
  end
end
