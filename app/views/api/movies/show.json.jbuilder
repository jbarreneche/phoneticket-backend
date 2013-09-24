json.(@movie, :id, :title, :synopsis, :youtube_trailer)
json.cover_url path_with_host(@movie.cover.url(:android))

shows_by_theatres = @movie.active_shows.group_by do |show|
  show.room.theatre
end

json.theatres shows_by_theatres.keys do |theatre|
  json.(theatre, :id, :name, :latitude, :longitude, :address)
  json.photo_url path_with_host(theatre.photo.url(:android))

  json.shows shows_by_theatres[theatre] do |show|
    json.(show, :id, :starts_at, :room)
  end
end
