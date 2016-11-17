require_relative 'board'
require_relative 'tile'
require 'byebug'

# TODO:
# there is some bug with IO that is preventing the game from working
# properly.

class Sudoku
  attr_reader :board
  def initialize(file_name)
    @board = Board.from_file(file_name)
  end

  def play
    until @board.solved?
      system("clear")
      play_turn
    end

    system("clear")
    puts @board.render
    puts "You solved it!"
  end

  def play_turn
    puts @board.render
    prompt_player
    pos, val = get_input
    @board.update_tile(pos, val)
  end

  def prompt_player
    puts "Enter a position and a value (ex: [0, 4]; 9)"
  end

  def get_input
    begin
      pos, val = parse_input(gets.chomp)
      valid_pos?(pos)
      valid_val?(val)
    rescue
      debugger
      puts "Invalid input. Try again!"
      retry
    end

    [pos, val]
  end

  def parse_input(str)
    pos, val = str.split(';')
    pos = pos.scan(/\d/).map(&:to_i)
    val = val.to_i
    [pos, val]
  end

  def valid_pos?(pos)
    raise unless pos.all? { |x| x.between?(0, 8) }
  end

  def valid_val?(val)
    raise unless val.between?(0,9)
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Sudoku.new(ARGV[0])
  ARGV.clear
  game.play
end
