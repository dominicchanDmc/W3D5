require 'byebug'
class PolyTreeNode
    attr_reader :children,:parent, :value

   def initialize(value)
    @children = []
    @parent = nil
    @value = value
   end
   
   def removeParent()
    @parent.children.reject!{|node| node == self}
    @parent = nil
   end

  def parent=(new_parent)
    return if parent == new_parent

    if parent
      parent.children.delete(self)
      parent = nil
    end

    @parent = new_parent
    new_parent.children << self unless new_parent.nil?
  end

    def add_child(child_node)
        # debugger
        # @children.push(child_node) if !@children.include?(child_node)           
        child_node.parent = self
    end

    def remove_child(child_node)
        # @children.reject!{|node| node == child_node}
        # @children.each do |ele|
        #     ele.parent if ele == child_node
        raise_error "Not a child" if @children.none?{|c| c == child_node}
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if target_value == self.value

        (0...@children.length).each do |i|
            node = @children[i].dfs(target_value)
           return node if !node.nil?
        end
        nil
    end

    # def bfs(target_value)
    #     # return self if target_value == self.value
    #     arry = [self]
    #     arry.each do |child|
    #        return child if child.value == target_value
    #        arry.concat(child.children)
    #     end
    #     nil
    # end
    def bfs(target_value)
        queue = [self]
    
        until queue.empty?
          current_node = queue.shift
          return current_node if current_node.value == target_value
          queue.concat(current_node.children)
        end
    
        nil
      end
end