module SignUpHelper
  def sign_up_as(user)
    SignUpPage.
        open.fill_form(
        user_name: user.full_name,
        email: user.email,
        password: user.password,
        password_confirmation: user.password).
        submit_form
    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account
    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')
  end

  def log_in_as(user)
    LoginPage.
        open.
        fill_form(email: user.email, password: user.password).
        submit_form
    expect(HomePage).to be_authenticated
    HomePage.wait_for_opened
  end

  def log_in_as_admin
    LoginPage.
        open.
        fill_form(email: "admin@strongqa.com", password: "1234567890").
        submit_form
    expect(HomePage).to be_authenticated
    HomePage.wait_for_opened
  end
end

RSpec.configure do |config|
  config.include SignUpHelper
end

