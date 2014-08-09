class PolyTreeNode

  def initialize(value = nil, children = [], parent = nil)
    @value = value
    @parent = parent
    @children = children
  end
  
  def dfs(value)
    return self if value == self.value
    @children.each do |child|
      result = child.dfs(value)
      return result if result
    end
    nil
  end
  
  def bfs(value)
    queue = [self]
    until queue.empty?
      queue.each do |node|
        node = queue.shift
        return node if node.value == value
        queue.concat(node.children)
      end
    end
    nil
  end
  
  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    if node && !node.children.include?(self)
      node.children << self
    end
  end
  
  def remove_child(node)
    raise "#{node} is not a child of #{self}" unless @children.include?(node)
    
    node.parent = nil
  end
  
  def add_child(node)
    node.parent = self
  end
  
  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value 
    @value
  end

end