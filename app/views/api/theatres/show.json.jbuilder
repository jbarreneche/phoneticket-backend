json.(@theatre, :id, :name, :latitude, :longitude, :address)
json.photo_url path_with_host(@theatre.photo.url(:android))

shows_by_movies = @theatre.active_shows.group_by do |show|
  show.movie
end

json.movies shows_by_movies.keys do |movie|
  json.(movie, :id, :title, :synopsis, :youtube_trailer, :director, :audience_rating)
  json.cast movie.cast.to_sentence
  json.genre human_genre(movie.genre)
  json.cover_url path_with_host(movie.cover.url(:android))

  json.shows shows_by_movies[movie] do |show|
    json.(show, :id, :starts_at, :room)
  end
end
