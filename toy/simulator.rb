require_relative '../lib/toy/robot'
require_relative '../lib/toy/table'
require_relative '../lib/toy/commander'
require_relative '../lib/toy/logibility'

module Toy
  class Simulator
    include Toy::Logibility

    def initialize(input = STDIN, output = STDOUT)
      @input = input
      @output = output

      table = Toy::Table.new(5, 5)
      robot = Toy::Robot.new
      @commander = Toy::Commander.new(robot: robot, table: table, output: @output)
    end

    def run
      show_welcome_messages

      if file_input?
        process_file
        show_exit_message
      else
        process_interactive
      end
    rescue Interrupt
      show_exit_message
    rescue => e
      log_error(e)
      @output.puts "Unexpected error: #{e.message}"
    end

    private

    def logger_name
      'simulator'
    end

    def show_welcome_messages
      @output.puts "Robot Simulator started. Enter commands (Ctrl-C or EXIT to exit):"
      @output.puts "Commands: PLACE X,Y,F | MOVE | LEFT | RIGHT | REPORT"
      @output.puts "-" * 50
    end

    def show_exit_message
      @output.puts "-" * 50
      @output.puts "Robot Simulator ended."
    end

    def file_input?
      !@input.isatty rescue true
    end

    def process_interactive
      while (command = @input.gets&.chomp.to_s.upcase)
        raise Interrupt if command == 'EXIT'

        @commander.run(command)
      end
    end

    def process_file
      command_buffer = []

      @input.each_line do |line|
        command = line.strip.upcase
        break if command == 'EXIT'

        command_buffer << command
        process_buffer(command_buffer) if command_buffer.size >= 1000
      end

      process_buffer(command_buffer) unless command_buffer.empty?
    end

    def process_buffer(command_buffer)
      command_buffer.each { |command| @commander.run(command) }
      command_buffer.clear
    end
  end
end

Toy::Simulator.new.run if $PROGRAM_NAME == __FILE__