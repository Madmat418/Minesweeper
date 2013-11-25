require_relative 'Tile.rb'
class Board
  attr_accessor :board_status

  def initialize(num_bombs = 20, size = 9)
    @board_status = create_board
  end

  def create_board(num_bombs, size)
    nodes = []
    Array.new(size) do |row|
      Array.new(size) do |col|
        node = Node.new([row, col])
        nodes << node
        node
      end
    end

    nodes.sample(num_bombs).each do |node|
      node.is_bomb = true
    end
  end



end