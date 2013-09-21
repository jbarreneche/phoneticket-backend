json.array! @movies do |movie|
  json.(movie, :title, :synopsis, :youtube_trailer)
end
