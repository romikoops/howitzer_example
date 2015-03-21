class ForgotPasswordPage < WebPage
  URL = '/users/password/new'
  validates :url, pattern: /\/users\/password/

  add_field_locator :email_input, 'user_email'
  add_button_locator :reset_password_button, 'Reset Password'

  def fill_email(email)
    fill_in(field_locator(:email_input), with: email) unless email.nil?
    self
  end

  def submit_form
    click_button button_locator(:reset_password_button)
  end
end