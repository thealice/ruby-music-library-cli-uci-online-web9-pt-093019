class Song

  extend Concerns::Findable

  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist=artist if artist
    self.genre=genre if genre
  end

  def self.all
    @@all
  end

  def self.destroy_all
    @@all.clear
  end

  def self.create(name)
    # song = self.new(name)
    # song.save
    # song
    self.new(name).tap do |song|
      song.save
    end
  end

  def save
    @@all << self
  end

  def artist=(artist_object)
    @artist = artist_object
    artist_object.add_song(self)
  end

  def genre=(genre_object)
    @genre = genre_object
    genre_object.songs << self unless genre_object.songs.include?(self)
  end

  def self.new_from_filename(filename)
    song_name = filename.split(" - ")[1]
    artist_name = filename.split(" - ")[0]
    genre_name = filename.split(" - ")[2].gsub(".mp3", "")
    artist_object = Artist.find_or_create_by_name(artist_name)
    genre_object = Genre.find_or_create_by_name(genre_name)
    new_song = Song.new(song_name, artist_object, genre_object)
  end

  def self.create_from_filename(filename)
    created_song = self.new_from_filename(filename)
    created_song.save
  end
end
