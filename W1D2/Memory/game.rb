require "byebug"
require_relative 'board'
require_relative 'player'

class Game
  attr_reader :board, :player

  def initialize(player)
    @board = Board.new
    @player = player
  end

  def get_guess
    begin
      player.prompt
      guess = player.get_input(board)
      board.check_pos(guess)
    rescue
      puts "Invalid guess"
      retry
    end

    player.receive(board.reveal(guess))

    render_board
    guess
  end

  def play_turn
    first_guess = get_guess
    second_guess = get_guess

    if match?(first_guess, second_guess)
      puts "You got a match!"
    else
      board.hide(first_guess)
      board.hide(second_guess)
      puts "They didn't match"
    end
  end

  def play
    welcome

    until game_over?
      system("clear")
      render_board
      play_turn
      gets
    end

    puts "You win!"
  end

  def render_board
    puts board.render
  end

  def game_over?
    board.won?
  end

  def welcome
    puts "Welcome!"
  end

  def match?(guess_1, guess_2)
    board[guess_1] == board[guess_2]
  end
end

if __FILE__ == $PROGRAM_NAME
  player = HumanPlayer.new
  board = Game.new(player)
  board.play
end
