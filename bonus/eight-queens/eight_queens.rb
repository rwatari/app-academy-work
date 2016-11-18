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
      place_next_row
      if @stuck
        remove_last_queen
      end

      while @stuck
        unstuck
      end

      render
      sleep(0.25)
      system("clear")
    end
  end

  def remove_last_queen
    @queens.pop
  end

  def shift_queen(queen)
    queen.move_to([queen.x, queen.y + 1])
  end

  def place_next_row
    # tries to place a queen in the next row
    # if it can't, it will set @stuck to true
    new_queen = Queen.new([next_row, 0])

    7.times do
      if queens.none? { |queen| queen.attacks?(new_queen) }
        place_queen(new_queen)
        return
      end

      shift_queen(new_queen)
    end

    @stuck = true
  end

  def unstuck
    last_queen = queens.pop
    shift_queen(last_queen)

    until queens.none? { |queen| queen.attacks?(last_queen) }
      shift_queen(last_queen)
    end

    if last_queen.y <= 7
      place_queen(last_queen)
      @stuck = false
    end
  end

  def first_queen
    place_queen(Queen.new([0, rand(0..7)]))
  end

  def place_queen(queen)
    queens << queen
  end

  def next_row
    queens.size
  end

  def render
    reset_board
    queens.each do |queen|
      @board[queen.x][queen.y] = "Q"
    end

    @board.each { |row| p row }
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
