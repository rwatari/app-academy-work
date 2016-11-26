class Towers
  attr_accessor :towers

  def initialize
    @towers = [[3, 2, 1], [], []]
  end

  def move(from, to)
    valid_move(from, to)
    @towers[to] << @towers[from].pop
  end

  def valid_move(from, to)
    if @towers[from].empty?
      raise "Empty tower"
    elsif !@towers[to].empty?
      raise "Invalid move" if @towers[from].last > @towers[to].last
    end
  end

  def won?
    @towers == [[], [3, 2, 1], []] || @towers == [[], [], [3, 2, 1]]
  end

  def get_input
    puts "Pick a tower to move from"
    from = get.chomp.to_i
    puts "Pick a tower to move to"
    to = get.chomp.to_i

    [from, to]
  end

  def play
    until won?
      begin
        from, to = get_input
        move(from, to)
      rescue
        retry
      end
    end
  end
end
