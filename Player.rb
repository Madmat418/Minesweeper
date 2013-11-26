class Player
  def move
    puts "Please make a move (eg. 'r [1,9]'):"
    begin
      input = gets.chomp
      raise "incorrect input" unless input =~ /[rf]\s\[[1-9]\,[1-9]\]/
    rescue
      puts "Formatting issue. Please use this format: (r/f [row,col])"
      retry
    end
    input = input.scan(/[rf]|[1-9]/)
  end
end