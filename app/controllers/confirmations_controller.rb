class ConfirmationsController < Devise::ConfirmationsController

  private

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    user_confirmed_path
  end
end
