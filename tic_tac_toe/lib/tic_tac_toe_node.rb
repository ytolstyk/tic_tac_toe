require_relative 'tic_tac_toe'

class TicTacToeNode
  POSITIONS =[[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]]
  
  attr_reader :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  
  def mark_swap(mark)
    mark == :x ? :o : :x
  end

  def children
    children_list = []
    unless @board.over?
      POSITIONS.each do |pos|
        children_list << make_child(pos) if @board.empty?(pos)
      end   
    end
    children_list
  end

  def make_child(pos)
    new_board = @board.dup
    new_board[pos] = @next_mover_mark
    return_val = TicTacToeNode.new(new_board, mark_swap(@next_mover_mark), pos)
    return_val
  end

  def losing_node?(evaluator)
    evaluator_swap = mark_swap(evaluator)
    return @board.winner == evaluator_swap if @board.over?
    
    if evaluator == @current_mark
      # are all children losers
      all_children_losers = true
      self.children.each do |node|
        all_children_losers = false unless node.losing_node?(evaluator)
      end
      all_children_losers
    else
      self.children.each do |node|
        return true if node.losing_node?(evaluator)
      end
      false
    end 
  end

  def winning_node?(evaluator)
    evaluator_swap = mark_swap(evaluator)
    return @board.winner == evaluator if @board.over?
    
    if evaluator == @current_mark
      self.children.each do |node|
        return true if node.winning_node?(evaluator)
      end
      false
    else
      all_children_winners = true
      self.children.each do |node|
        all_children_winners = false unless node.winning_node?(evaluator)
      end
      all_children_winners
    end
  end
end
