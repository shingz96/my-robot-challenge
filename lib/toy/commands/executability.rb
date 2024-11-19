module Toy
  module Commands
    module Executability
      def execute
        return unless match_data

        super
      end

      def match_data
        @command.match(self.class.command_regex)
      end
    end
  end
end
