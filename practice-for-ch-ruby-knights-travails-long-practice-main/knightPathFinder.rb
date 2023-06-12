require_relative 'tree_node.rb'

class KnightPathFinder
    MOVES = [
        [-2, -1],
        [-2, 1],
        [-1, -2],
        [-1, 2],
        [1, -2],
        [1, 2],
        [2, -1],
        [2, 1]
      ]
      attr_reader :start_pos, :considered_positions
    def initialize(start_pos)
        @start_pos = start_pos
        @considered_positions = [start_pos]
        build_move_tree
    end

    def root_node
        @root_node ||= PolyTreeNode.new(@start_pos)
    end

    def new_move_positions(pos)
        valid_moves = KnightPathFinder.valid_moves(pos)
        valid_moves.reject { |move| @considered_positions.include?(move) }
                    .each { |move| @considered_positions << move }
    end

    def self.valid_moves(pos)
        x, y = pos
        MOVES.map { |mx, my| [x + mx, y + my] }
             .select { |new_x, new_y| new_x >= 0 && new_x <= 7 && new_y >= 0 && new_y <= 7 }
    end

    def build_move_tree
        queue = [root_node]
        until queue.empty?
            current_node = queue.shift
            current_pos = current_node.value
            new_move_positions(current_pos).each do |next_pos|
              next_node = PolyTreeNode.new(next_pos)
              current_node.add_child(next_node)
              queue << next_node
            end
        end
    end
    
    def find_path(end_pos)
        end_node = root_node.bfs(end_pos)
        trace_path_back(end_node)
    end
      
    def trace_path_back(end_node)
        path = []
        current_node = end_node
    
        until current_node.nil?
          path.unshift(current_node.value)
          current_node = current_node.parent
        end
    
        path
      end
end