require 'spec_helper'

feature "Viewing Users" do
  scenario "User is viewing other user on user page" do
    user = Gen::given_user_by_number(0)
    user1 = Gen::given_user_by_number(1)
    sign_up_as(user)
    sign_up_as(user1)
    log_in_as(user1)
    UsersPage.open.click_link user.email
    expect(UserViewPage.given.text).to include(user.email)
  end
end