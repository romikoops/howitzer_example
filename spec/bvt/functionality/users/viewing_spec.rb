require 'spec_helper'

feature "Viewing Users" do
  scenario "User is viewing other user on user page" do
    user = Gen::given_user_by_number(0)
    sign_up_as(Gen::given_user_by_number(0))
    sign_up_as(Gen::given_user_by_number(1))
    log_in_as(Gen::given_user_by_number(1))
    UsersPage.open.click_link user.email

    expect(UserViewPage.given.text).to include(user.email)
  end
end