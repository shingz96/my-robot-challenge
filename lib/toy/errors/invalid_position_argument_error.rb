require_relative 'custom_error'

module Toy
  module Errors
    class InvalidPositionArgumentError < CustomError
      def initialize(x: nil, y: nil, direction: nil)
        super
        @x = x
        @y = y
        @direction = direction
      end

      def message
        if @direction
          "Invalid direction argument: #{@direction}"
        else
          "Invalid position arguments: x=#{@x}, y=#{@y}"
        end
      end
    end
  end
end
