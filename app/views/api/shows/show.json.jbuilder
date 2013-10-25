reserved_seat_codes = @show.seats.pluck(:code)

json.partial! @show

json.status do |json|
  @show.room.room_shape.each_body do |body|
    json.set! body.name do
      json.rows body.rows
      json.columns body.columns
      json.seats body.to_matrix
      json.void_seats body.void_places
      json.reserved_seats(reserved_seat_codes.select do |seat_code|
        body.has_place? seat_code
      end)
    end
  end
end

json.prices @show.prices

json.promotions @show.promotions, partial: "api/promotions/promotion", as: :promotion
