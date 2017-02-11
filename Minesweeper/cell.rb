class Cell

  attr_reader :revealed, :content

  def initialize(content = "[]")
    @content = content
    @revealed = false
  end

  def set_tile!(stuff)
    @content = stuff
  end

  def reveal
    @revealed = true
  end

  def set_number!
    @content = ((@content.to_i) + 1).to_s + " " if (@content == "[]" || @content.to_i > 0)
  end

end
