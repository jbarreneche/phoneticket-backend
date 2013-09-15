class ConfirmationPreview < MailView
  # Pull data from existing fixtures
  def show
    user = User.first || User.create(email: "someone@somewhere.com", password: "123456")
    user.confirmed_at = nil
    user.send :generate_confirmation_token!
    token = user.instance_variable_get "@raw_confirmation_token"
    Devise::Mailer.confirmation_instructions(user, token)
  end

end
