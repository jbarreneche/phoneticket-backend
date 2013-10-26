json.(reservation, :id)
json.seats reservation.seats.map(&:code)
json.share_url reservation_url(reservation)
json.show do
  json.theatre do
    json.(reservation.show.room.theatre, :id, :name)
  end
  json.partial! "api/shows/show", show: reservation.show
end
