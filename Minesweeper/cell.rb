class Cell

  attr_reader :revealed, :content

  def initialize(content = nil)
    @content = content
    @revealed = false
  end

  def set_tile!(stuff)
    @content = stuff
  end

  def reveal
    @revealed = true
    @content = "O " if @content.nil?
  end

  def set_number!
    @content = ((@content.to_i) + 1).to_s + " " if (@content.nil? || @content.to_i > 0)
  end

  def empty?
    return true if @content.nil?
    false
  end

  def has_number?
    return true if @content.to_i > 0
    false
  end

  def has_mine?
    return true if @content == "M "
    false
  end

end
