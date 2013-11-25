require_relative 'Tile.rb'
class Board
  attr_accessor :board

  def initialize(num_bombs = 20, size = 9)
    nodes = []
    @board = Array.new(size) do |row|
      Array.new(size) do |col|
        p row
        p col
        # node = Node.new([row, col])
#         nodes << node
#         node
      end
    end

    nodes.sample(num_bombs).each do |node|
      node.is_bomb = true
    end
  end

  def get_neighbors(node)

  end


end