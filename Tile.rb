class Tile
  attr_accessor :position, :is_bomb, :is_revealed, :is_flagged

  def initialize(position)
    @position = position
    @is_bomb = false
    @is_revealed = false
    @is_flagged = false
    @bomb_count = 0
  end

  def reveal
    @is_revealed = true
    @is_bomb
  end

  def to_s
    return 'F' if @is_flagged
    return '*' unless @is_revealed
    @bomb_count > 0 ? @bomb_count.to_s : '_'
  end


end