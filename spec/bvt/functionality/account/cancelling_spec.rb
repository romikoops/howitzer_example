require 'spec_helper'

feature "Account cancelling" do
  scenario "User can cancel his own account if he is signed in" do
    user_signs_up (Gen::given_user_by_number(0))
    user_logs_in_into_system (Gen::given_user_by_number(0))

    EditAccountPage.open
                   .cancel_my_account
    accept_alert
    expect(HomePage.given.text).to include("Bye! Your account was successfully cancelled. We hope to see you again soon.")
  end

end


