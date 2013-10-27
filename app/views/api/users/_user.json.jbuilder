json.errors @user.errors if @user.errors.any?
json.(@user, :email, :first_name, :last_name, :phone_number, :date_of_birth, :document, :address)

json.purchases @user.unfinished_purchases, partial: "api/purchases/purchase", as: :purchase

json.reservations @user.unfinished_reservations, partial: "api/reservations/reservation", as: :reservation
