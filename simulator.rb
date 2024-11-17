Dir.glob('lib/**/*.rb') { |f| require_relative f }

class Simulator
  def initialize(input = STDIN, output = STDOUT)
    @input = input
    @output = output

    table = Table.new(5, 5)
    robot = Robot.new(table)
    @commander = Commander.new(robot, output: output)
  end

  def run
    show_welcome_messages

    if file_input?
      process_file
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

  def log_error(error)
    logger = Logger.new('logs/simulator.log')
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))
  end

  def show_welcome_messages
    @output.puts "Robot Simulator started. Enter commands (Ctrl-C or EXIT to exit):"
    @output.puts "Commands: PLACE X,Y,F | MOVE | LEFT | RIGHT | REPORT"
    @output.puts "-" * 50
  end

  def show_exit_message
    @output.puts "\nSimulator terminated."
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

Simulator.new.run if $PROGRAM_NAME == __FILE__
