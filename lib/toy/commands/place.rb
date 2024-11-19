require_relative 'base'

module Toy
  module Commands
    class Place < Base
      def execute
        _, x, y, direction = match_data.to_a
        @position = Position.new(x: x.to_i, y: y.to_i, direction: direction)
        return unless @table.valid_position?(@position.y, @position.y)

        @robot.position = @position
      rescue ArgumentError
        return
      end

      def self.command_regex
        /^PLACE\s+(\d+),(\d)+,(NORTH|EAST|SOUTH|WEST)$/
      end
    end
  end
end
