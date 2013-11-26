require_relative 'Player.rb'
require_relative 'Board.rb'
require_relative 'Tile.rb'
class Minesweeper
  attr_reader :size

  def initialize(player,num_bombs, size)
    @player = player
    @size = size
    @board = Board.new(num_bombs, size)
    nil
  end

  def play
    until won?
      puts @board
      player_input = @player.move
      tile = @board.board_status[player_input[1].to_i-1][player_input[2].to_i-1]
      bomb = (player_input[0] == 'r' ? @board.reveal(tile) : @board.flag(tile))
      if bomb == 'bomb'
        @board.tiles.each do |tile|
          tile.is_revealed = true
          tile.is_flagged = false
        end
        puts @board
        puts "Boom! You lose!"
        puts "Bomb at: #{tile.position.map {|a| a+1 }}"
        return
      end
    end
    puts @board
    puts "Congratulations! You won!"
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