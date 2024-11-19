require_relative 'custom_error'

module Toy
  module Errors
    class InvalidPositionError < CustomError
      def initialize(position)
        super
        @position = position
      end

      def message
        "Invalid position: #{@position.pretty_print}"
      end
    end
  end
end
