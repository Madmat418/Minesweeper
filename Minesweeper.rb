require_relative 'Player.rb'
require_relative 'Board.rb'
require_relative 'Tile.rb'
class Minesweeper

  def initialize(player)
    @player = player
    @board = Board.new()
    nil
  end

  def play
    until won?
      puts @board
      player_input = @player.move
      tile = @board.board_status[player_input[1].to_i-1][player_input[2].to_i-1]
      player_input[0] == 'r' ? @board.reveal(tile) : @board.flag(tile)
    end
  end


end

ms = Minesweeper.new(Player.new)
ms.play