require_relative 'main_menu'

class LoginPage < WebPage
  URL = '/users/sign_in'
  validates :title, pattern: /\ADemo web application - Log In\z/
  validates :url, pattern: /\/sign_in\/?\z/

  add_locator :login_btn, '[name="commit"]'

  add_field_locator :email_input, 'user_email'
  add_field_locator :password_input, 'user_password'
  add_field_locator :remember_me, 'user_remember_me'

  add_link_locator :sign_up_link, 'new_user_sign_up'
  add_link_locator :forgot_password_link, 'Forgot password?'

  include MainMenu

  def fill_form(email: nil, password: nil, remember_me: nil)
    fill_in(field_locator(:email_input), with: email) unless email.nil?
    fill_in(field_locator(:password_input), with: password) unless password.nil?
    check(field_locator(:remember_me)) unless remember_me.nil?
    self
  end

  def submit_form
    js_click(locator(:login_btn))
  end

  def login_as(email, password, remember_me=false)
    log.info "Login with: Email=#{email}, Password=#{password}, Remember Me=#{remember_me}"
    fill_form(email: email, password: password, remeber_me: remember_me)
    submit_form
    HomePage.given
  end
end