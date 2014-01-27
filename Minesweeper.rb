require_relative 'Board.rb'
require_relative 'Tile.rb'
class Minesweeper
  attr_reader :size, :num_bombs

  def initialize(num_bombs, size)
    puts "Please enter the size of the board you would like.  
	For example: '9' will give you a 9x9 grid."
    @size = gets.chomp.to_i
	puts "Please enter the number of bombs you wish to play with."
    @num_bombs = gets.chomp.to_i
    @board = Board.new(@size)
  end

  def play
    @placed_bombs = false
    until self.won?
      puts @board
      player_input = self.move
      tile = which_tile(player_input)
	  unless @placed_bombs
	    @board.place_bombs(@num_bombs, tile)
		@placed_bombs = true
	  end		
      player_input[0] == 'r' ? @board.reveal(tile) : @board.flag(tile)
      if self.lost?
        self.loser
        puts "Bomb at: #{tile.position.map {|a| a+1 }}"
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

  def which_tile(input)
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
  end

  def lost?
    @board.tiles.any? do |tile|
      tile.is_bomb && tile.is_revealed
    end
  end

  def won?
    @board.tiles.all? do |tile|
      tile.is_revealed || tile.is_bomb
    end
  end
end

ms = Minesweeper.new(20, 9)
ms.play