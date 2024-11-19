require_relative 'custom_error'

module Toy
  module Errors
    class InvalidCommandError < CustomError
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
