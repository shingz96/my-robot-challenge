require_relative 'commands/place'
require_relative 'commands/left'
require_relative 'commands/right'
require_relative 'commands/move'
require_relative 'commands/report'
require_relative 'formatter/output'
require_relative 'errors/invalid_command_error'

module Toy
  class Commander
    def initialize(robot:, table:)
      @robot = robot
      @table = table
    end

    def run(command, output = Toy::Formatter::Output.new)
      command_class = command_classes.detect { |klass| klass.command_regex =~ command }
      raise Toy::Errors::InvalidCommandError.new(command) unless command_class

      command_class.new(robot: @robot, table: @table, command: command, output: output).execute
    rescue => error
      output.print_error(error)
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
