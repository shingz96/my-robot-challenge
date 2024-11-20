module Toy
  module Formatter
    class Input
      def initialize(input)
        @input = input
      end

      def file_input?
        !@input.isatty rescue true
      end

      def iterator
        if file_input?
          @input.each_line.map(&:chomp).map(&:upcase)
        else
          Enumerator.new do |yielder|
            loop do
              yielder.yield @input.gets.chomp.to_s.upcase
            end
          end
        end
      end
    end
  end
end
