require_relative './board.rb'

class Game

  def initialize
    @board = Board.new
  end

  def run
    until is_won?
      system "clear"
      @board.render
      pos = get_coords
      play_round(pos)
    end
  end

  private

  def play_round(coords)
    @board.reveal(coords)
  end

  def is_won?
    @board.hidden_mines == 0
  end

  def get_coords
    puts "Which row and column? (ex: 0, 1)"
    row, col = gets.chomp.split(",").map{ |el| el.to_i }
    [row, col]
  end

end

g = Game.new
g.run
