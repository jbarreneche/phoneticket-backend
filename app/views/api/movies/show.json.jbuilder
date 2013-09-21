json.(@movie, :id, :title, :synopsis, :youtube_trailer)

shows_by_theatres = @movie.active_shows.group_by do |show|
  show.room.theatre
end

json.theatres shows_by_theatres.keys do |theatre|
  json.(theatre, :name)

  json.shows shows_by_theatres[theatre] do |show|
    json.(show, :id, :starts_at, :room)
  end
end