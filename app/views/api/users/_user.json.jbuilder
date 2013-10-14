json.errors @user.errors if @user.errors.any?
json.(@user, :email, :first_name, :last_name, :phone_number, :date_of_birth, :document, :address)

json.purchases @user.unfinished_purchases do |purchase|
  json.(purchase, :id)
  json.seats purchase.seats.map(&:code)
  json.show do
    json.theatre do
      json.(purchase.show.room.theatre, :id, :name)
    end
    json.partial! "api/shows/show", show: purchase.show
  end
end

json.reservations @user.unfinished_reservations do |reservation|
  json.(reservation, :id)
  json.seats reservation.seats.map(&:code)
  json.show do
    json.theatre do
      json.(reservation.show.room.theatre, :id, :name)
    end
    json.partial! "api/shows/show", show: reservation.show
  end
end
