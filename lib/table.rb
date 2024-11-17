class Table
  def initialize(width, height)
    raise ArgumentError, 'Width and height must be positive integers' unless width.positive? && height.positive?

    @width = width
    @height = height
  end

  def valid_position?(x, y)
    x >= 0 && x < @width &&
      y >= 0 && y < @height
  end
end
