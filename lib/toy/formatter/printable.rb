module Toy
  module Formatter
    module Printable
      def pretty_print
        raise NotImplementedError, 'You must implement pretty_print'
      end
    end
  end
end
