class Robot
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  attr_reader :x, :y, :direction

  def initialize(table)
    raise ArgumentError, 'Table must be a Table object' unless table.is_a?(Table)

    @table = table
    @placed = false
  end

  def placed?
    !!@placed
  end

  def place(x, y, direction)
    return unless @table.valid_position?(x, y) && DIRECTIONS.include?(direction)

    @x = x
    @y = y
    @direction = direction
    @placed = true
  end

  def move
    return unless placed?

    new_x, new_y =
      case @direction
      when 'NORTH' # up
        [@x, @y + 1]
      when 'EAST' # right
        [@x + 1, @y]
      when 'SOUTH' # down
        [@x, @y - 1]
      when 'WEST' # left
        [@x - 1, @y]
      end

    @x, @y = new_x, new_y if @table.valid_position?(new_x, new_y)
  end

  def left
    return unless placed?

    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) - 1) % 4]
  end

  def right
    return unless placed?

    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) + 1) % 4]
  end

  def report
    return unless placed?

    "#{@x},#{@y},#{@direction}"
  end
end
