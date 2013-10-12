class Api::UsersController < Api::BaseController
  include Devise::Controllers::Helpers

  def create
    @user = User.new user_params

    if @user.save
      render @user
    else
      warden.custom_failure!
      render @user, status: 422
    end
  end

  def show
    @user = User.find_by_email! params[:email]

    render @user
  end

  def update
    @user = User.find_by_email! user_params[:email]

    if @user.update_attributes user_params
      render @user
    else
      render @user, status: 422
    end
  end

  def sessions
    @user = User.find_for_database_authentication(email: user_params[:email])

    return invalid_login_attempt unless @user

    if @user.valid_password?(user_params[:password])
      sign_in(@user)

      render @user
    else
      invalid_login_attempt
    end
  end

  private

  def invalid_login_attempt
    warden.custom_failure!

    render json: {error: I18n.t("devise.failure.invalid")}, status: :unauthorized
  end

  def user_params
    params.permit(:email, :password, :password_confirmation,
      :first_name, :last_name, :date_of_birth, :document,
      :address, :phone_number)
  end

end
