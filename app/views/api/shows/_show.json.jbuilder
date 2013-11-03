json.(show, :id, :room, :numbered_seats)
json.starts_at show.starts_at
json.movie do
  json.partial! show.movie
end
