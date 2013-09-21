json.array! @movies do |movie|
  json.(movie, :title, :synopsis, :youtube_trailer)
  json.cover_url movie.cover.url
end
