require_relative 'tile'

class Board
  ONE_TO_NINE = (1..9).to_a

  SQUARE = [
    [0,0], [0,1], [0,2],
    [1,0], [1,1], [1,2],
    [2,0], [2,1], [2,2]
  ]

  SQUARE_CORNERS = [
    [0,0], [0,3], [0,6],
    [3,0], [3,3], [3,6],
    [6,0], [6,3], [6,6]
  ]

  SQUARES = SQUARE_CORNERS.map do |corner|
    SQUARE.map do |pos|
      [corner[0] + pos[0], corner[1] + pos[1]]
    end
  end

  def self.create_grid(file_name)
    grid = []

    f = File.open(file_name)

    f.each_line.with_index do |line, i|
      row = line.chomp.split("").map(&:to_i)

      grid << row.map.with_index do |num, j|
        Tile.new(num, [i, j])
      end
    end

    grid
  end

  def self.from_file(file_name)
    Board.new(self.create_grid(file_name))
  end

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def update_tile(pos, val)
    self[pos].value = val
  end

  def render
    grid.map { |row| render_row(row) }.join(divider)
  end

  def divider
    "\n#{'-' * 26}\n"
  end

  def render_row(row)
    row.map(&:to_s).join("|")
  end

  def solved?
    rows_solved? && cols_solved? && squares_solved?
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def rows_solved?
    shape_solved?(grid)
  end

  def cols_solved?
    shape_solved?(grid.transpose)
  end

  def squares_solved?
    SQUARES.all? do |square|
      values = square.map { |pos| self[pos].value }
      values.sort == ONE_TO_NINE
    end
  end

  def shape_solved?(shape)
    shape.all? do |row|
      values = row.map(&:value)
      values.sort == ONE_TO_NINE
    end
  end
end
