class Queen
  attr_reader :x, :y

  def initialize(pos)
    @x, @y = pos
    @line_procs = [same_row?, same_col?, same_diag?]
  end

  def attacks?(other_queen)
    @line_procs.any? { |line| line.call(other_queen) }
  end

  def move_to(pos)
    @x, @y = pos
  end

  private

  def same_row?
    Proc.new do |other_queen|
      other_queen.x == x
    end
  end

  def same_col?
    Proc.new do |other_queen|
      other_queen.y == y
    end
  end

  def same_diag?
    Proc.new do |other_queen|
      (other_queen.x - x).abs == (other_queen.y - y).abs
    end
  end
end
