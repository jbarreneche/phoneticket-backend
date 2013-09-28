json.errors @user.errors if @user.errors.any?
json.(@user, :email, :first_name, :last_name, :phone_number, :date_of_birth, :document, :address)
