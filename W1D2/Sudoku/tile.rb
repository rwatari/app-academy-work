class Tile
  attr_reader :given, :value

  def initialize(value)
    @value = value
    @given = !value.zero?
  end

  def value=(val)
    @value = val unless given
  end

  def to_s
    if @given
      ".#{@value}"
    elsif value.zero?
      "  "
    else
      " #{@value}"
    end
  end
end
