require_relative './board.rb'

class Game

  def initialize
    @board = Board.new
  end

  def run
    until is_won?
      system "clear"
      @board.render
      command = get_command
      if command.class == Array
        break unless play_round(command)
      else
        mine!
      end
    end
    winner if is_won?
  end

  private

  def mine!
    puts "Type where a mine is!"
    pos = gets.chomp.split(",").map{ |e| e.to_i }
    @board.safe(pos)
  end

  def winner
    system "clear"
    @board.render
    puts "YOU WON!!!!"
  end

  def play_round(coords)
    return @board.reveal(coords)
  end

  def is_won?
    @board.hidden_mines == 0
  end

  def get_command
    puts "Type C for coordinates or M for mine"
    command = gets.chomp
    if command == "M"
      return command
    else
      return command.split(",").map{ |e| e.to_i }
    end
  end

end

g = Game.new
g.run
