json.errors @user.errors if @user.errors.any?
json.(@user, :email, :first_name, :last_name, :phone_number, :date_of_birth, :document, :address)

json.purchases @user.purchases do |purchase|
  json.(purchase, :id)
  json.show do
    json.partial! "api/shows/show", show: purchase.show
  end
end

json.reservations @user.reservations do |reservation|
  json.(reservation, :id)
  json.show do
    json.partial! "api/shows/show", show: reservation.show
  end
end
