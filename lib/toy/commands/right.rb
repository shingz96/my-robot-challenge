require_relative 'base'

module Toy
  module Commands
    class Right < Base
      def execute
        return unless @robot.placed?

        @robot.position = @robot.position.right
      end

      def self.command_regex
        /^RIGHT$/
      end
    end
  end
end
