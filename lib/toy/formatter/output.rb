module Toy
  module Formatter
    class Output
      def initialize(output = STDOUT)
        @output = output
      end

      def print(object)
        @output.puts object.pretty_print
      end

      def print_error(error)
      end
    end
  end
end
