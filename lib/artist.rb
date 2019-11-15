class Artist

  extend Concerns::Findable

  attr_accessor :name, :songs

  @@all = []

  def initialize(name)
    @name = name
    @songs = []
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def save
    @@all << self
  end

  def self.create(name)
    self.all.detect {|artist| artist.name == name } ||
    self.new(name).tap do |artist|
      artist.save
    end
    # artist = self.new(name)
    # artist.save
    # artist
  end

  def add_song(song)
    song.artist = self unless song.artist
    @songs << song unless @songs.include?(song)
    # @genres << song.genre unless @genres.include?(song)
  end

  def genres
    genres_array = []
    @songs.each do |song|
      genres_array << song.genre unless genres_array.include?(song.genre)
    end
    genres_array
  end

end
