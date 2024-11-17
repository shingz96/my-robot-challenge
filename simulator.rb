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
    @output.puts "Robot Simulator started. Enter commands (Ctrl-C or EXIT to exit):"
    @output.puts "Commands: PLACE X,Y,F | MOVE | LEFT | RIGHT | REPORT"
    @output.puts "-" * 50

    while (command = @input.gets&.chomp)
      raise Interrupt if command.to_s.upcase == 'EXIT'
      @commander.run(command)
    end
  rescue Interrupt
    @output.puts "\nSimulator terminated."
  end
end

Simulator.new.run if $PROGRAM_NAME == __FILE__
