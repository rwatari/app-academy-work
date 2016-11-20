require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_board = game.board
    current_node  = TicTacToeNode.new(current_board, mark)

    children = current_node.children

    children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    raise "No non-losing or winning moves available"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
