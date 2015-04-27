require 'spec_helper'

feature "Account Editing" do
  scenario "User can edit password and name with correct credentials" do
    user = Gen.user
    user1 = Gen.user
    SignUpPage.open.sign_up_as(user.full_name, user.email, user.password)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account

    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    LoginPage.open.login_as(user.email, user.password)
    EditAccountPage.open
    EditAccountPage.given.
        fill_form(user_name: user1.full_name,
                  password: user1.password,
                  password_confirmation: user1.password,
                  current_password: user.password).submit_form
    expect(HomePage.given.text).to include('You updated your account successfully.')
    HomePage.given.choose_menu('Logout')
    expect(HomePage).to_not be_authenticated
    LoginPage.open
    LoginPage.given.fill_form(email: user.email,
                  password: user1.password).submit_form
    expect(HomePage).to be_authenticated
    EditAccountPage.open
    expect(EditAccountPage.given.form_data).to eq({user_name: user1.full_name,
                                                   email: user.email,
                                                   password: '',
                                                  password_confirmation: '',
                                                  current_password: ''})
  end

  scenario "User can edit email with correct credentials" do
    user = Gen.user
    user1 = Gen.user
    SignUpPage.open.sign_up_as(user.full_name, user.email, user.password)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account

    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    LoginPage.open.login_as(user.email, user.password)
    EditAccountPage.open
    EditAccountPage.given.
        fill_form(user_name: user.full_name,
                  email: user1.email,
                  password: '',
                  password_confirmation: '',
                  current_password: user.password).submit_form
    expect(HomePage.given.text).to include('You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address.')
    ConfirmationInstructionEmail.
        find_by_recipient(user1.email).
        confirm_my_account
    expect(HomePage.given.text).to include('Your account was successfully confirmed.')
    HomePage.given.choose_menu('Logout')
    expect(HomePage).to_not be_authenticated
    LoginPage.open
    LoginPage.given.fill_form(email: user1.email,
                              password: user.password).submit_form
    expect(HomePage).to be_authenticated
    expect(HomePage.given.text).to include('Signed in successfully.')
  end

  scenario "User can not edit account with incorrect email" do
    user = Gen.user
    SignUpPage.open.sign_up_as(user.full_name, user.email, user.password)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account

    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    LoginPage.open.login_as(user.email, user.password)
    EditAccountPage.open
    EditAccountPage.given.
        fill_form(email: 'test@.ua',
                  current_password: user.password).submit_form
    EditAccountPage.wait_for_opened
  end

  scenario "User can not edit account with existing email" do
    user = Gen.user
    SignUpPage.open.sign_up_as(user.full_name, user.email, user.password)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account

    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    user1 = Gen.user
    SignUpPage.open.sign_up_as(user1.full_name, user1.email, user1.password)

    ConfirmationInstructionEmail.
        find_by_recipient(user1.email).
        confirm_my_account

    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    LoginPage.open.login_as(user1.email, user1.password)
    EditAccountPage.open
    EditAccountPage.given.
        fill_form(email: user.email,
                  current_password: user1.password).submit_form
    expect(EditAccountPage.given.text).to include("1 error prohibited this user from being saved: Email has already been taken")
  end

  scenario "User can not edit account with incorrect password" do
    user = Gen.user
    user1 = Gen.user
    SignUpPage.open.sign_up_as(user.full_name, user.email, user.password)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account

    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    LoginPage.open.login_as(user.email, user.password)
    EditAccountPage.open
    EditAccountPage.given.
        fill_form(password: user1.password,
                  password_confirmation: user1.password,
                  current_password: 'incorrect_password').submit_form
    expect(EditAccountPage.given.text).to include("1 error prohibited this user from being saved: Current password is invalid")
  end

  scenario "User can not edit account with incorrect password confirmation" do
    user = Gen.user
    SignUpPage.open.sign_up_as(user.full_name, user.email, user.password)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account

    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    LoginPage.open.login_as(user.email, user.password)
    EditAccountPage.open
    EditAccountPage.given.
        fill_form(password: '12345678',
                  password_confirmation: '123456789',
                  current_password: user.password).submit_form
    expect(EditAccountPage.given.text).to include("1 error prohibited this user from being saved: Password confirmation doesn't match Password")
  end

  scenario "User can not edit account with short password (less then 8 characters)" do
    user = Gen.user
    SignUpPage.open.sign_up_as(user.full_name, user.email, user.password)

    ConfirmationInstructionEmail.
        find_by_recipient(user.email).
        confirm_my_account

    expect(LoginPage.given.text).to include('Your account was successfully confirmed.')

    LoginPage.open.login_as(user.email, user.password)
    EditAccountPage.open
    EditAccountPage.given.
        fill_form(password: '1234567',
                  password_confirmation: '1234567',
                  current_password: user.password).submit_form
    expect(EditAccountPage.given.text).to include("1 error prohibited this user from being saved: Password is too short (minimum is 8 characters)")
  end
end