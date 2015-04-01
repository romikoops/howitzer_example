require 'spec_helper'

feature "Account cancelling" do
  scenario "Visitor can cancel his own account if he is signed in" do
    user_signs_up
    user_logs_in_into_system
    EditAccountPage.open
                   .given.cancel_my_account
                   .accept_alert
    expect(HomePage.given.text).to include("Bye! Your account was successfully cancelled. We hope to see you again soon.")
  end

end


