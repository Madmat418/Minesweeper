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

  def won?
    revealed_counter = 0
    @board.tiles.each do |tile|
      revealed_counter += 1 if tile.is_revealed
    end
    revealed_counter == @board.tiles.length - @board.num_bombs ? true : false
  end


end

ms = Minesweeper.new(Player.new)
ms.play