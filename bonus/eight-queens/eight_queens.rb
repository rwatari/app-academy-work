require_relative 'queen'

class QueensSolver
  def initialize
    @board = Array.new(8) { Array.new(8) }
    @queens = []
  end

  def solve
    until solved?
      # check if it's possible to place queen
      # if not, move current queen to next available space
      # if we have tried all available spaces for current queen,
      #   remove queen
      #   move current queen to next available space
    end
  end

  def test_next_row
    # makes a new queen, then tries to place it in the next row
    # if no available spaces, ??????
    new_queen = Queen.new([next_row, 0])

    8.times do |col|
      new_queen.move_to([next_row, col])

      next if queens.any? { |queen| queen.attacks?(new_queen) }

      place_queen(new_queen)
    end

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

  private

  attr_reader :queens

  def solved?
    queens.size == 8
  end
end
