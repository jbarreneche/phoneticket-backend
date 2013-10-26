json.(show, :id, :starts_at, :room, :numbered_seats)
json.movie do
  json.partial! show.movie
end
