require_relative 'queen'

class QueensSolver
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @queens = []
    @stuck = false
    first_queen
  end

  def solve
    until solved?
      test_next_row
      if @stuck
        remove_last_queen
        #shift queen to next space
      end
    end
  end

  def shift_queen
    last_queen = @queens.last

    #TODO
  end

  def remove_last_queen
    @queens.pop
  end

  def test_next_row
    new_queen = Queen.new([current_row, 0])

    8.times do |col|
      new_queen.move_to([current_row, col])

      next if queens.any? { |queen| queen.attacks?(new_queen) }

      place_queen(new_queen)
      @stuck = false
    end

    @stuck = true
  end

  def first_queen
    place_queen(Queen.new([current_row, rand(0..7)]))
  end

  def place_queen(queen)
    queens << queen
  end

  def current_row
    queens.size
  end

  def next_row
    current_row + 1
  end

  def render
    reset_board
    queens.each do |queen|
      @board[queen.x][queen.y] = "Q"
    end

    @board
  end

  def reset_board
    @board = Array.new(8) { Array.new(8) }
  end

  private

  attr_reader :queens

  def solved?
    queens.size == 8
  end
end
