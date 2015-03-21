class ChangePasswordPage < WebPage
  URL = '/users/password/new'
  validates :url, pattern: /\/users\/password/

  add_field_locator :password_input, 'user_password'
  add_field_locator :confirm_password_input, 'user_password_confirmation'
  add_button_locator :submit_form, 'Change my password'

  def fill_form(pass,confirm_pass)
    fill_in(field_locator(:password_input), with: pass) unless pass.nil?
    fill_in(field_locator(:confirm_password_input), with: confirm_pass) unless confirm_pass.nil?
    self
  end

  def submit_form
    click_button button_locator(:submit_form)
  end
end