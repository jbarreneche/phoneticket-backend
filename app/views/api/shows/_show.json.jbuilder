json.(show, :id, :starts_at, :room)
json.movie do
  json.partial! show.movie
end
