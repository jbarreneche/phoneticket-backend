json.errors @user.errors if @user.errors.any?
json.(@user, :email)
