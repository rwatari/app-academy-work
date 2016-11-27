# eight-queens without the queen object
# board is 1-D array with numbers representing the queen pos in a row
require 'colorize'

class QueensSolver
  attr_accessor :queens

  def initialize(board_size = 8)
    @board_size = board_size
    @queens = []
    @stuck = false
  end

  def render_board
    board = []
    @board_size.times do |row|
      row_str = ""
      @board_size.times do |col|
        str = (@queens[row] == col ? " Q " : "   ")
        row_str << str.colorize(background: color(row, col))
      end
      board << row_str
    end

    puts board.join("\n")
  end

  def solve
    until solved?
      place_next_queen
      if @stuck
        remove_last_queen
        unstick
      end
    end
  end

  private

  def solved?
    @queens.length == @board_size
  end

  def unstick
    while @stuck
      next_col = @queens.pop + 1

      next_col += 1 while queens_attack?(next_row, next_col)

      if next_col < @board_size
        @queens << next_col
        @stuck = false
      end
    end
  end

  def remove_last_queen
    @queens.pop
  end

  def place_next_queen
    next_col = 0

    (@board_size - 1).times do
      if queens_attack?(next_row, next_col)
        next_col += 1
      else
        @queens << next_col
        return
      end
    end

    @stuck = true
  end

  def next_row
    @queens.size
  end

  def color(row, col)
    (row + col).even? ? :white : :light_grey
  end

  def queens_attack?(row, col)
    @queens.each_with_index do |cl, rw|
      if rw == row || cl == col || (rw - row).abs == (cl - col).abs
        return true
      end
    end

    false
  end
end
