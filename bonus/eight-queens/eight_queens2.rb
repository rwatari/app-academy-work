# eight-queens without the queen object
# board is 1-D array with numbers representing the queen pos in a row
require 'colorize'

class QueensSolver
  def initialize
    @queens = []
  end

  def render_board
    board = []
    8.times do |row|
      row_str = ""
      8.times do |col|
        row_str << " ".colorize(:background => color(row, col))
      end
      board << row_str
    end

    puts board.join("\n")
  end

  def color(row, col)
    (row + col).even? ? :white : :light_grey
  end
end
