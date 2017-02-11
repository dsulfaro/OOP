require_relative './cell.rb'

class Board

  attr_reader :board, :size, :hidden_mines
  attr_accessor :revealed_mines

  def initialize(size = 8)
    @board = []
    @size = size
    set_board!
    @hidden_mines = size
  end

  def [](*pos)
    x, y = pos
    @board[x][y]
  end

  def reveal(pos)
    x, y = pos
    if invalid?(pos)
      puts "Invalid position"
      sleep(0.8)
    elsif @board[x][y].revealed
      puts "That square is already revealed!"
      sleep(0.8)
    else
      return branch_out(x, y)
    end
  end

  def safe(pos)
    i = pos[0]
    j = pos[1]
    if @board[i][j].content == "M "
      @board[i][j].set_tile!("S ")
      @hidden_mines -= 1
      @board[i][j].reveal
    end
  end

  def render
    print "   0 1 2 3 4 5 6 7"
    puts ""
    i = 0
    @board.each do |arr|
      print i.to_s + " "
      arr.each do |cell|
        if cell.revealed
          print cell.content
        else
          print "[]"
        end
      end
      puts ""
      i += 1
    end
  end

  private

  def lose!
    system "clear"
    puts "Wow, you suck!!! You lost hahahaha!"
    @board.each do |arr|
      arr.each do |cell|
        cell.reveal if cell.has_mine?
      end
    end
    render
  end

  def add_neighbors(x, y)
    result = []
    #left side of cell
    if y > 0
      result << [x, y - 1]
      result << [x - 1, y - 1] if x > 0
      result << [x + 1, y - 1] if x < @size - 1
    end
    #right side of cell
    if y < @size - 1
      result << [x, y + 1]
      result << [x - 1, y + 1] if x > 0
      result << [x + 1, y + 1] if x < @size - 1
    end
    #above and below
    result << [x - 1, y] if x > 0
    result << [x + 1, y] if x < @size - 1

    result
  end

  def branch_out(x, y)
    @board[x][y].reveal
    if @board[x][y].has_mine?
      lose!
      return false
    else
      return if @board[x][y].has_number?
      add_neighbors(x, y).each do |n|
        next if @board[n[0]][n[1]].has_mine?
        branch_out(n[0], n[1]) if @board[n[0]][n[1]].empty? || @board[n[0]][n[1]].has_number?
      end
      return true
    end
  end

  def invalid?(pos)
    x, y = pos
    return true if x < 0 || x >= @board.size
    return true if y < 0 || y >= @board.size
    false
  end

  def set_numbers!(x, y)
    add_neighbors(x, y).each { |pos| @board[pos[0]][pos[1]].set_number! }
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
