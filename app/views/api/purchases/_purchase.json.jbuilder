json.(purchase, :id)
json.seats purchase.seats.map(&:code)
json.share_url purchase_url(purchase)
json.show do
  json.theatre do
    json.(purchase.show.room.theatre, :id, :name)
  end
  json.partial! "api/shows/show", show: purchase.show
end
