class Board
  attr_accessor :board

  def initialize(num_bombs = 20, size = 9)
    nodes = []
    @board = Array.new(size) do
      Array.new(size) do
        node = Node.new
        nodes << node
        node
      end
    end

    nodes.sample(num_bombs).each do |node|
      node.is_bomb = true
    end
  end



end