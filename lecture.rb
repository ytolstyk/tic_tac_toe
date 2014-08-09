def dfs(target)
  return self if self.value == target
  self.children.each do |child|
    result = child.dfs(target)
    return result if result
  end
  nil
end



def bfs(target)
  queue = [self]
  until queue.empty?
    current_node = queue.shift
    return current_node if current_node == target
    queue.concat(current_node.children)
  end
  nil
end