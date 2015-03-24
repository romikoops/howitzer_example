require 'spec_helper'

feature "Log In" do
  scenario "Visitor can open login page via menu" do
    HomePage.
        open.
        choose_menu('Login')
    LoginPage.wait_for_opened
  end
  scenario "Visitor can login with correct credentials" do
    LoginPage.
        open.
        fill_form(email: 'admin@strongqa.com', password: '1234567890').
        submit_form
    expect(HomePage).to be_authenticated
    HomePage.wait_for_opened
  end
end