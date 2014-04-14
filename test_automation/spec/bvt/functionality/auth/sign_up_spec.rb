require 'spec_helper'

feature "Sign Up" do
  scenario "Visitor can open sign up page via menu" do
    HomePage.open.choose_menu('Sign up')
    SignUpPage.given
  end

  scenario "User can sign up with correct data" do
    user = Gen::given_user_by_number(0)
    SignUpPage.open.fill_form(
        user_name: user.full_name,
        email: user.email,
        password: user.password,
        password_confirmation: user.password
    ).submit_form
    expect(HomePage).to_not be_authenticated
    confirmation_text = "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    expect(HomePage.given.text).to include(confirmation_text)
    ConfirmationInstructionEmail.find_by_recipient(user.email).confirm_my_account
    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')
    LoginPage.given.fill_form(email: user.email, password: user.password).submit_form
    expect(HomePage).to be_authenticated
    HomePage.given
  end

end