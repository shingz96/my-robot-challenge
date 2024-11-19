require_relative 'executable'

module Toy
  module Commands
    class Base
      prepend Toy::Commands::Executable

      def initialize(command:, robot:, table:, output:)
        @command = command
        @robot = robot
        @table = table
        @output = output
      end

      def execute
        raise NotImplementedError, 'You must implement the execute method'
      end

      def logger_name
        'commands'
      end

      def self.command_regex
        raise NotImplementedError, 'You must implement the command_regex method'
      end
    end
  end
end
