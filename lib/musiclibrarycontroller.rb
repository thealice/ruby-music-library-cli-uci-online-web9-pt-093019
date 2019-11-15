class MusicLibraryController

  attr_accessor :path, :list_songs

  def initialize(path = "./db/mp3s")
    @path = path
    importer = MusicImporter.new(path)
    importer.import
  end

  def call
    input = ""
    instructions = ["Welcome to your music library!","To list all of your songs, enter 'list songs'.","To list all of the artists in your library, enter 'list artists'.","To list all of the genres in your library, enter 'list genres'.","To list all of the songs by a particular artist, enter 'list artist'.", "To list all of the songs of a particular genre, enter 'list genre'.", "To play a song, enter 'play song'.", "To quit, type 'exit'." , "What would you like to do?" ]
    # this loop will run until user types "exit"
    while input != "exit"

      instructions.each { |text| puts text }
      input = gets.chomp.downcase

      case input
      when "list songs"
        list_songs
      when "list artists"
        list_artists
      when "list genres"
        list_genres
      when "list artist"
        list_songs_by_artist
      when "list genre"
        list_songs_by_genre
      when "play song"
        play_song
      end

    end
  end

  def list_songs
    song_list = Song.all.sort { |song1, song2| song1.name <=> song2.name }
    song_list.each.with_index(1) do |song, index|
      puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
    end
  end

  def list_artists
    artist_list = Artist.all.sort { |artist1, artist2| artist1.name <=> artist2.name }
    artist_list.each.with_index(1) { |artist, index| puts "#{index}. #{artist.name}" }
  end

  def list_genres
    genre_list = Genre.all.sort { |genre1, genre2| genre1.name <=> genre2.name }
    genre_list.each.with_index(1) { |genre, index| puts "#{index}. #{genre.name}"}
  end

  def list_songs_by_artist
    puts "Please enter the name of an artist:"
    artist_name = gets.chomp
    if Artist.find_by_name(artist_name)
        list = Artist.find_by_name(artist_name).songs.sort do |song1, song2|
          song1.name <=> song2.name
        end
        list.each.with_index(1) do |song, index|
          puts "#{index}. #{song.name} - #{song.genre.name}"
        end
    end
  end

  def list_songs_by_genre
    puts "Please enter the name of a genre:"
    genre_name = gets.chomp
    genre = Genre.find_by_name(genre_name)

    if genre
      list = genre.songs.sort { |genre1, genre2| genre1.name <=> genre2.name }
      list.each.with_index(1) do |song, index|
        puts "#{index}. #{song.artist.name} - #{song.name}"
      end
    end
  end

  def play_song
      puts "Which song number would you like to play?"
      input = gets.chomp.to_i
      num = Song.all.count

      if (1..num).include?(input)
        song = Song.all.sort{ |a, b| a.name <=> b.name }[input - 1]
      end

      puts "Playing #{song.name} by #{song.artist.name}" if song
    end

end
