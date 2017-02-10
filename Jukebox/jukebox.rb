class Track
  def initialize(title, album, artist, duration)
    @title, @album, @artist, @duration = title, album, artist, duration
  end
end

def Album
  def initialize(title, tracks, artist, year)
    @title, @tracks, @artist, @year = title, tracks, artist, year
  end
end

def Artist
  def initialize(title, tracks, albums)
    @title, @tracks, @albums = title, tracks, albums
  end
end

class Player

  def initialize
  end

  def play(track)
  end

  def is_playing?
  end

end

class Jukebox

  def initialize
    @player = Player.new
    @tracks = Array.new(Track.new)
    @queue = []
  end

  def queue_up(track)
    @queue.shift(track)
  end

  def play
    @player.play(@queue.pop) unless @player.is_playing?
  end

end
