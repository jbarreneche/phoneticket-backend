json.array! @movies do |movie|
  json.(movie, :id, :title, :synopsis, :youtube_trailer, :director, :audience_rating)
  json.cast movie.cast.to_sentence
  json.genre human_genre(movie.genre)
  json.cover_url path_with_host(movie.cover.url(:android))
  json.resource_url api_movie_url(movie)
end
