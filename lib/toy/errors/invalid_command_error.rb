module Toy
  module Errors
    class InvalidCommandError < StandardError
      def initialize(command)
        super
        @command = command
      end

      def message
        "Invalid command: #{@command}"
      end
    end
  end
end
