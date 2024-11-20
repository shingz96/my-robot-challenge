require_relative 'base'

module Toy
  module Commands
    class Left < Base
      def execute
        return unless @robot.placed?

        @robot.position = @robot.position.left
      end

      def self.command_regex
        /^LEFT$/
      end
    end
  end
end
