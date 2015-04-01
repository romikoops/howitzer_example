module SignUpHelper
  def user_signs_up
    user = Gen::given_user_by_number(0)
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

  def user_logs_in_into_system
    user = Gen::given_user_by_number(0)
    LoginPage.
        open.
        fill_form(email: user.email, password: user.password).
        submit_form
    expect(HomePage).to be_authenticated
    HomePage.wait_for_opened
  end




end