class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_resending_confirmation_instructions_path_for(resource)
    users_confirmation_sent_path
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    users_confirmed_path
  end
end
