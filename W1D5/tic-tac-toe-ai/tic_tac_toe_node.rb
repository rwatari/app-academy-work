require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return false if @board.winner.nil?
      return @board.winner != evaluator
    end

    kids = children
    if evaluator == @next_mover_mark
      return kids.all? { |child| child.losing_node?(evaluator) }
    else
      return kids.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?

    kids = children
    if evaluator == @next_mover_mark
      return kids.any? { |child| child.winning_node?(evaluator) }
    else
      return kids.all? { |child| child.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_array = []

    @board.rows.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        pos = [row_idx, col_idx]
        next unless @board.empty?(pos)

        new_board = @board.dup
        new_board[pos] = @next_mover_mark
        new_node = TicTacToeNode.new(new_board, switch_mark, pos)
        children_array << new_node
      end
    end

    children_array
  end

  def switch_mark
    @next_mover_mark == :x ? :o : :x
  end
end
