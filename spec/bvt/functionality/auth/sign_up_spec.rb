require 'spec_helper'

feature "Sign Up" do
  scenario "Visitor can open sign up page via menu" do
    HomePage.
        open.
        choose_menu('Sign up')
    SignUpPage.wait_for_opened
  end

  scenario "Visitor can initiate sign up" do
    LoginPage.
        open.
        choose_menu('Sign up')
    SignUpPage.wait_for_opened
  end

  scenario "User can sign up with correct data" do
    user = Gen::given_user_by_number(0)
    SignUpPage.
        open.fill_form(
           user_name: user.full_name,
           email: user.email,
           password: user.password,
           password_confirmation: user.password
        ).
        submit_form

    expect(HomePage).to_not be_authenticated
    confirmation_text = "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    expect(HomePage.given.text).to include(confirmation_text)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account
    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    LoginPage.
        given.
        fill_form(email: user.email, password: user.password).
        submit_form
    expect(HomePage).to be_authenticated
    HomePage.wait_for_opened
  end

  scenario "User can not sign up with blank data" do
    user = Gen::given_user_by_number(0)
    SignUpPage.
        open.fill_form(
        user_name:nil,
        email:nil,
        password:nil,
        password_confirmation:nil
    ).
        submit_form

    expect(HomePage).to_not be_authenticated
    error_text = "2 errors prohibited this user from being saved: Email can't be blank Password can't be blank"
    expect(SignUpPage.given.text).to include(error_text)

    SignUpPage.
        open.fill_form(
        user_name:nil,
        email:user.email,
        password:nil,
        password_confirmation:nil
    ).
        submit_form

    expect(HomePage).to_not be_authenticated
    error_text = "1 error prohibited this user from being saved: Password can't be blank"
    expect(SignUpPage.given.text).to include(error_text)

    SignUpPage.
        open.fill_form(
        user_name:nil,
        email:nil,
        password:user.password,
        password_confirmation:user.password
    ).
        submit_form

    expect(HomePage).to_not be_authenticated
    error_text = "1 error prohibited this user from being saved: Email can't be blank"
    expect(SignUpPage.given.text).to include(error_text)
  end

  scenario "User can not sign up with incorrect data" do
    user = Gen::given_user_by_number(0)
    SignUpPage.
        open.fill_form(
        user_name:nil,
        email:'test.1234567890',
        password:nil,
        password_confirmation:nil
    ).
        submit_form
    expect(HomePage).to_not be_authenticated
    error_text = "2 errors prohibited this user from being saved: Email is invalid Password can't be blank"
    expect(SignUpPage.given.text).to include(error_text)

    SignUpPage.
        open.fill_form(
        user_name:nil,
        email:user.email,
        password:'1234567',
        password_confirmation:'1234567'
    ).
        submit_form

    expect(HomePage).to_not be_authenticated
    error_text = "1 error prohibited this user from being saved: Password is too short (minimum is 8 characters)"
    expect(SignUpPage.given.text).to include(error_text)

    SignUpPage.
        open.fill_form(
        user_name:nil,
        email:user.email,
        password:'1234567890',
        password_confirmation:'1234567890123'
    ).
        submit_form

    expect(HomePage).to_not be_authenticated
    error_text = "1 error prohibited this user from being saved: Password confirmation doesn't match Password"
    expect(SignUpPage.given.text).to include(error_text)
  end

  scenario "User cannot sign up with duplicated email" do
    user_signs_up
    user = Gen::given_user_by_number(0)
    SignUpPage.
        open.fill_form(
        user_name:user.full_name,
        email:user.email,
        password:user.password,
        password_confirmation:user.password
    ).
        submit_form

    expect(HomePage).to_not be_authenticated
    error_text = "1 error prohibited this user from being saved: Email has already been taken"
    expect(SignUpPage.given.text).to include(error_text)
  end
end