json.array! @movies do |movie|
  json.(movie, :id, :title, :synopsis, :youtube_trailer)
  json.cover_url movie.cover.url
  json.resource_url api_movie_url(movie)
end
