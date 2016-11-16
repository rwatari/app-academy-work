require "byebug"
require_relative "card"

class Board

  def initialize
    @grid = Array.new(4)
    populate
  end

  def size
    [grid.size, grid[0].size]
  end

  def won?
    grid.flatten.all?(&:face_up)
  end

  def reveal(pos)
    card = self[pos]
    unless card.face_up
      card.reveal
      card.display
    end
  end

  def hide(pos)
    self[pos].hide
  end

  def render
    grid.map { |row| render_row(row) }.join("\n")
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def check_pos(pos)
    # debugger
    raise "Invalid pos" if self[pos].nil?
  end

  private

  attr_reader :grid

  def render_row(row)
    row.map(&:display).join(" | ")
  end

  def populate
    cards = []

    2.times do
      1.upto(10) do |i|
        cards << Card.new(i)
      end
    end
    cards.shuffle!

    4.times do |i|
      @grid[i] = cards.shift(5)
    end
  end
end
