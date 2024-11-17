require 'logger'

class Commander
  def initialize(robot, output: STDOUT)
    raise ArgumentError, 'Robot must be a Robot object' unless robot.is_a?(Robot)

    @robot = robot
    @output = output
  end

  def run(command)
    parts = command.strip.split
    action = parts[0]

    case action
    when 'PLACE'
      x, y, direction = parts[1].split(',')
      @robot.place(x.to_i, y.to_i, direction)
    when 'MOVE'
      @robot.move
    when 'LEFT'
      @robot.left
    when 'RIGHT'
      @robot.right
    when 'REPORT'
      @output.puts @robot.report
    else
      @output.puts "Invalid command: #{command}"
    end
  rescue => e
    log_error(e)
    @output.puts "Unexpected error: #{e.message}"
  end

  private

  def log_error(error)
    logger = Logger.new('logs/commander.log')
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))
  end
end
