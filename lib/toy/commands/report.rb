require_relative 'base'

module Toy
  module Commands
    class Report < Base
      def execute
        return unless @robot.placed?

        @output.print @robot.position
      end

      def self.command_regex
        /^REPORT$/
      end
    end
  end
end
