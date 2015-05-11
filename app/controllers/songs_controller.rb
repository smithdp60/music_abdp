class SongsController < ApplicationController

  def random_artists

    # Randomly chooses genre from user preferences
    genres_max = @current_user.genres.count - 1
    genre = @current_user.genres[rand(0..genres_max)]

    # render :json => genre.name


    # Get list of artists by specified genre
    artists = RSpotify::Artist.search('genre:' + "Pop")
    # artists = RSpotify::Artist.search('genre:' + genre.name)
    ## Fix so that errors don't occur on some genres

    # Gets three unique index numbers
    random_indices = Set.new
    while random_indices.count < 3 do
      random_indices << rand(artists.count)
    end

    # Gets three random artists based on index numbers
    random_artists = random_indices.map do |index|
      artists[index].name
    end

    render :json => random_artists

    # Separates the three random artist names
    artist0 = random_artists[0]
    artist1 = random_artists[1]
    artist2 = random_artists[2]

    # artist0 song preview w/ album art
    song0 = RSpotify::Track.search('artist:' + artist0, limit: 50)
    song0_random = song0[rand(0..40)]
    @song0_cover = song0_random.album.images[0]['url']
    @song0_url = song0_random.preview_url

    # render :json => song0_random.name

  end

end