require_relative 'main_menu'

class SignUpPage < WebPage
  URL = '/users/sign_up'
  validates :title, pattern: /\ADemo web application - Sign Up\z/

  add_field_locator :user_name_input, 'user_name'
  add_field_locator :email_input, 'user_email'
  add_field_locator :password_input, 'user_password'
  add_field_locator :password_confirmation_input, 'user_password_confirmation'

  add_button_locator :sign_up_btn, 'Sign up'

  include MainMenu

  def fill_form(params={})
    fill_in(field_locator(:user_name_input), with: params[:username]) if params[:username]
    fill_in(field_locator(:email_input), with: params[:email]) if params[:email]
    fill_in(field_locator(:password_input), with: params[:password]) if params[:password]
    fill_in(field_locator(:password_confirmation_input), with: params[:password_confirmation]) if params[:password_confirmation]
  end

  def submit_form
    click_button button_locator(:sign_up_btn)
  end

  def sign_up_as(user_name, email, password)
    log.info "Sign up with: User name=#{user_name}, Email=#{email}, Password=#{password}"
    fill_form(user_name: user_name, email: email, password: password, password_confirmation: password)
    submit_form
    HomePage.given
  end
end