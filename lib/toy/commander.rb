require_relative 'commands/place'
require_relative 'commands/left'
require_relative 'commands/right'
require_relative 'commands/move'
require_relative 'commands/report'

module Toy
  class Commander
    def initialize(robot:, table:, output: STDOUT)
      @robot = robot
      @table = table
      @output = output
    end

    def run(command)
      command_class = command_classes.detect { |klass| klass.command_regex =~ command }
      return false unless command_class

      command_class.new(robot: @robot, table: @table, command: command, output: @output).execute
      true
    end

    private

    def command_classes
      [
        Commands::Place,
        Commands::Left,
        Commands::Right,
        Commands::Move,
        Commands::Report
      ]
    end
  end
end
