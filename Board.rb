require_relative 'Tile.rb'
class Board
  attr_accessor :board_status

  def initialize(num_bombs = 20, size = 9)
    @board_status = create_board(num_bombs,size)
  end

  def create_board(num_bombs, size)
    tiles = []
    board = Array.new(size) do |row|
      Array.new(size) do |col|
        tile = Tile.new([row, col])
        tiles << tile
        tile
      end
    end

    tiles.sample(num_bombs).each do |tile|
      tile.is_bomb = true
    end
    board
  end



  def get_neighbors(tile)
    neighbor_tiles = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        next if x == 0 && y == 0
        new_tile_x = tile.position[0] + x
        new_tile_y = tile.position[1] + y
        next if new_tile_x < 0 || new_tile_x > 8
        next if new_tile_y < 0 || new_tile_y > 8
        neighbor_tiles << @board_status[new_tile_x][new_tile_y]
      end
    end
    neighbor_tiles
  end

  def neighbor_bomb_count(neighbors)
    bomb_count = 0
    neighbors.each do |tile|
      bomb_count += 1 if tile.is_bomb
    end
    bomb_count
  end

  def reveal(tile)
    return if tile.is_revealed
    tile.is_revealed = true
    neighbors = get_neighbors(tile)
    bomb_count = neighbor_bomb_count
    if tile.is_bomb
      #Boom
    elsif bomb_count > 0
      bomb_count(neighbors)
    else
      neighbors.each do |neighbor|
        reveal(neighbor)
      end
    else

  end

  def flag(tile)
    tile.is_flagged = !tile.is_flagged
  end
end