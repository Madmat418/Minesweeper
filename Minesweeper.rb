require_relative 'Player.rb'
require_relative 'Board.rb'
require_relative 'Tile.rb'
class Minesweeper
  attr_reader :size, :num_bombs

  def initialize(num_bombs, size)
    @size = size
    @num_bombs = num_bombs
    @board = Board.new(num_bombs, size)
  end

  def play
    until self.won?
      puts @board
      player_input = self.move
      tile = tile(player_input)
      player_input[0] == 'r' ? @board.reveal(tile) : @board.flag(tile))
      if self.lost?
        self.loser
        return
      end
    end
    puts @board
    puts "Congratulations! You won!"
  end

  def move
    puts "Please make a move (eg. 'r [1,9]'):"
    begin
      input = gets.chomp
      raise "incorrect input" unless input =~ /[rf]\s\[[0-9]+\,[0-9]+\]/
    rescue
      puts "Formatting issue. Please use this format: (r/f [row,col])"
      retry
    end
    input = input.scan(/[rf]|[0-9]+/)
  end

  def tile(input)
    row, col = input[1].to_i-1, input[2].to_i-1
    @board.board_status[row][col]
  end

  def loser
    @board.tiles.each do |tile|
      tile.is_revealed = true
      tile.is_flagged = false
    end
    puts @board
    puts "Boom! You lose!"
    puts "Bomb at: #{tile.position.map {|a| a+1 }}"
  end

  def lost?
    @board.tiles.none? do |tile|
      tile.is_bomb && tile.is_revealed
    end
  end

  def won?
    @board.tiles.all? do |tile|
      tile.is_revealed || tile.is_bomb
    end
  end
end

ms = Minesweeper.new(Player.new)
ms.play