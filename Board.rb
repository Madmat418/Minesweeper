require_relative 'Tile.rb'
class Board
  attr_accessor :board_status

  def initialize(num_bombs = 20, size = 9)
    @board_status = create_board(num_bombs,size)
  end

  def create_board(num_bombs, size)
    tiles = []
    Array.new(size) do |row|
      Array.new(size) do |col|
        tile = Tile.new([row, col])
        tiles << tile
        tile
      end
    end

    tiles.sample(num_bombs).each do |tile|
      tile.is_bomb = true
    end
  end

  def get_neighbors(tile_position)
    neighbor_tiles = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        next if x == 0 && y == 0
        new_tile_x = tile_position[0] + x
        new_tile_y = tile_position[1] + y
        next if new_tile_x < 0 || new_tile_x > 8
        next if new_tile_y < 0 || new_tile_y > 8
        neighbor_tiles << @board_status[new_tile_x][new_tile_y]
      end
    end
    neighbor_tiles
  end

  def reveal(tile)
    tile.reveal = true
  end

  def flag(tile)
    tile.is_flagged = !tile.is_flagged
  end
end