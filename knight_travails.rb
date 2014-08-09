require "./00_tree_node.rb"

class KnightPathFinder
  DIFFS = [[1, 2], [1, -2], [-1, -2], [-1, 2], [2, 1], [2, -1], [-2, 1], [-2, -1]]

  def self.on_board?(pos)
    x, y = pos
    x <= 7 && x >= 0 && y <= 7 && y >= 0
  end
  
  def self.valid_moves(pos)
    x, y = pos
    [].tap do |moves|
      DIFFS.each do |move|
        new_x = x + move[0]
        new_y = y + move[1]
        moves << [new_x, new_y] if self.on_board?([new_x, new_y])
      end
    end
  end
  
  def initialize(position = [0, 0])
    @start = position
    @visited_pos = [position]
    build_move_tree
  end

  def find_path(end_pos)
    node = @tree.dfs(end_pos)
    path = [node.value]
    until path.include?(@start)
      node = node.parent
      path.unshift(node.value)
    end
    display_answer(path)
  end
  
  private
  
  def display_answer(path)
    puts "We found #{path.last} for you:"
    path.each { |pos| p pos }
  end
  
  def build_move_tree
    @tree = PolyTreeNode.new(@start)
    queue = [@tree]
    until queue.empty?
      node = queue.shift
      queue = new_move_positions(node, queue)
    end
  end
  
  def node_moves (node)
    self.class.valid_moves(node.value)
  end

  def new_move_positions(node, queue)
    new_positions = node_moves(node)
    new_positions.each do |new_pos|
      unless @visited_pos.include?(new_pos)
        @visited_pos << new_pos
        child_node = PolyTreeNode.new(new_pos)
        child_node.parent = node
        queue << child_node
      end
    end
    queue
  end
end

if __FILE__ == $PROGRAM_NAME
  kpf = KnightPathFinder.new
  kpf.find_path([7,7])
  kpf.find_path([7, 6])
  kpf.find_path([6, 2])
end