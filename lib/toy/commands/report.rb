require_relative 'base'

module Toy
  module Commands
    class Report < Base
      def execute
        return unless @robot.placed?

        @output.puts "#{@robot.position.x},#{@robot.position.y},#{@robot.position.direction}"
      end

      def self.command_regex
        /^REPORT$/
      end
    end
  end
end
