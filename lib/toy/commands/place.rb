require_relative 'base'
require_relative '../errors/invalid_position_error'

module Toy
  module Commands
    class Place < Base
      def execute
        _, x, y, direction = match_data.to_a
        new_position = Position.new(x: x.to_i, y: y.to_i, direction: direction)
        raise Toy::Errors::InvalidPositionError.new(new_position) unless @table.valid_position?(new_position.x, new_position.y)

        @robot.position = new_position
      end

      def self.command_regex
        /^PLACE\s+(\d+),(\d+),(NORTH|EAST|SOUTH|WEST)$/
      end
    end
  end
end
