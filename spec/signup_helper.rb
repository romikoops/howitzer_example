module SignUpHelper
  def user_signs_up
     user = Gen.user
     DataStorage.store(:user, 'user_name', user.full_name)
     DataStorage.store(:user, 'email', user.email)
     DataStorage.store(:user, 'password', user.password)
     SignUpPage.
         open.fill_form(
          user_name: user.full_name,
          email: user.email,
          password: user.password,
          password_confirmation: user.password)
        .submit_form
    expect(HomePage).to_not be_authenticated
    confirmation_text = "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    expect(HomePage.given.text).to include(confirmation_text)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account
    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')
  end
end