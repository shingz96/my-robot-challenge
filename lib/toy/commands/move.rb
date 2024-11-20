require_relative 'base'

module Toy
  module Commands
    class Move < Base
      def execute
        return unless @robot.placed?

        new_position = @robot.position.move
        @robot.position = new_position if @table.valid_position?(new_position.x, new_position.y)
      end

      def self.command_regex
        /^MOVE$/
      end
    end
  end
end
