class Cell

  attr_accessor :content
  attr_reader :revealed

  def initialize(content = "[]")
    @content = content
    @revealed = false
  end

  def reveal
    @revealed = true
  end

end
