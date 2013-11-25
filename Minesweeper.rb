require_relative 'Player.rb'
require_relative 'Board.rb'
require_relative 'Tile.rb'
class Minesweeper

  def initialize(player)
    @player = player
    @board = Board.new()
  end

  def play
    puts @board
  end

end