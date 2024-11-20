require_relative '../lib/toy/robot'
require_relative '../lib/toy/table'
require_relative '../lib/toy/commander'
require_relative '../lib/toy/logable'
require_relative '../lib/toy/formatter/input'
require_relative '../lib/toy/formatter/output'
require 'dotenv'

Dotenv.load

module Toy
  class Simulator
    include Toy::Logable

    def initialize(input = STDIN, output = STDOUT, robot, table)
      @input = input
      @output = output
      @command_buffer = []

      @input_formatter = Toy::Formatter::Input.new(input)
      @output_formatter = Toy::Formatter::Output.new(output)
      @commander = Toy::Commander.new(robot: robot, table: table)
    end

    def run
      show_welcome_messages

      @input_formatter.iterator.each do |command|
        break if command == 'EXIT'

        buffer_size = @input_formatter.file_input? ? ENV['MAX_FILE_BUFFER'].to_i : 1

        @command_buffer << command
        process_buffer if @command_buffer.size >= buffer_size
      end

      process_buffer unless @command_buffer.empty?

      show_exit_message
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

    def process_buffer
      @command_buffer.each { |command| process_single_command(command) }
      @command_buffer.clear
    end

    def process_single_command(command)
      @commander.run(command, @output_formatter)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  robot = Toy::Robot.new
  table = Toy::Table.new(ENV['TABLE_WIDTH'].to_i, ENV['TABLE_HEIGHT'].to_i)
  Toy::Simulator.new(STDIN, STDOUT, robot, table).run
end
