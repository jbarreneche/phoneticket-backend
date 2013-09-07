class Api::UsersController < Api::BaseController

  def create
    @user = User.new user_params

    if @user.save
      render @user
    else
      warden.custom_failure!
      render @user, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
