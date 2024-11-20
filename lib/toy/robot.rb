require_relative 'position'

module Toy
  class Robot
    attr_accessor :position

    def placed?
      @position.is_a?(Toy::Position) && !@position.nil?
    end
  end
end
