require_relative 'Tile.rb'
class Board
  attr_accessor :board_status, :num_bombs, :tiles

  def initialize(num_bombs = 3, size = 20)
    @num_bombs = num_bombs
    @size = size
    @tiles = []
    @board_status = board(num_bombs,size)
  end

  def board(num_bombs, size)
    board = Array.new(size) do |row|
      Array.new(size) do |col|
        tile = Tile.new([row, col])
        @tiles << tile
        tile
      end
    end

    @tiles.sample(num_bombs).each do |tile|
      tile.is_bomb = true
    end
    board
  end

  def to_s
    output = ''
    @board_status.each do |row|
      line_output = ''
      row.each do |tile|
        line_output << tile.to_s + ' '
      end
      output << line_output + "\n"
    end
    output
  end

  def neighbors(tile)
    neighbor_tiles = []
    (-1..1).each do |x|
      (-1..1).each do |y|
        next if x == 0 && y == 0
        new_tile_x = tile.position[0] + x
        new_tile_y = tile.position[1] + y

        if new_tile_x.between?(0,@size-1) and new_tile_y.between?(0,@size-1)
          neighbor_tiles << @board_status[new_tile_x][new_tile_y]
        end
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
    if tile.is_flagged
      puts "Tile is flagged.  Unflag before revealing."
      return
    end
    tile.is_revealed = true
    neighbors = neighbors(tile)
    bomb_count = neighbor_bomb_count(neighbors)
    if tile.is_bomb
      "bomb"
    elsif bomb_count > 0
      tile.bomb_count = bomb_count
    else
      neighbors.each do |neighbor|
        reveal(neighbor)
      end
    end
  end

  def flag(tile)
    if tile.is_revealed
      puts "This tile is already revealed."
      return
    end
    tile.is_flagged = !tile.is_flagged
  end
end