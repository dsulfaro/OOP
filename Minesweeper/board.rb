require_relative './cell.rb'

class Board

  def initialize(size=8)
    @board = []
    @size = size
    set_board!
  end

  def [](*pos)
    x, y = pos
    @board[x][y]
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

  def set_numbers!(x, y)
    if y > 0
      @board[x][y - 1].set_number!
      if x > 0
        @board[x - 1][y - 1].set_number!
      end
      if x < @size - 1
        @board[x + 1][y - 1].set_number!
      end
    end

    if y < @size - 1
      @board[x][y + 1].set_number!
      if x > 0
        @board[x - 1][y + 1].set_number!
      end
      if x < @size - 1
        @board[x + 1][y + 1].set_number!
      end
    end

    if x > 0
      @board[x - 1][y].set_number!
    end

    if x < @size - 1
      @board[x + 1][y].set_number!
    end
  end

  def set_mines!
    num_mines = @size
    random_range = (0..@size - 1).to_a
    until num_mines == 0
      x = random_range.sample
      y = random_range.sample
      random_spot = @board[x][y]
      unless random_spot.content == "M "
        random_spot.set_tile!("M ")
        set_numbers!(x, y)
        num_mines -= 1
      end
    end
  end

  def set_board!
    @size.times do
      row = []
      @size.times do
        row << Cell.new
      end
      @board << row
    end
    set_mines!
  end
end

b = Board.new
b.render
