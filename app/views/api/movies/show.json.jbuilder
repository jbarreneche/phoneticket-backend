json.partial! @movie

shows_by_theatres = @shows.group_by do |show|
  show.room.theatre
end

json.theatres shows_by_theatres.keys do |theatre|
  json.(theatre, :id, :name, :latitude, :longitude, :address)
  json.photo_url path_with_host(theatre.photo.url(:android))

  json.shows shows_by_theatres[theatre] do |show|
    json.(show, :id, :starts_at, :room)
  end
end
