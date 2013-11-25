class Tile
  attr_accessor :position, :is_bomb, :is_revealed, :is_flagged

  def initialize(position)
    @position = position
    @is_bomb = false
    @is_revealed = false
    @is_flagged = false
  end

  def reveal
    @is_revealed = true
    @is_bomb
  end

  def get_neighbors(tile)

  end


end