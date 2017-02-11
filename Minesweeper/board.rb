require_relative './cell.rb'

class Board

  def initialize(size=8)
    @board = []
    @size = size
    set_board!
  end

  def render
    @board.each do |arr|
      arr.each do |cell|
        print cell.content
      end
      puts ""
    end
  end

  private

  def set_board!
    @size.times do
      row = []
      @size.times do
        row << Cell.new
      end
      @board << row
    end
  end

end

b = Board.new
b.render
