#############################################################
#                      ACTIONS                              #
#############################################################
When /^I click 'Cancel account' button on Edit account page$/ do
  EditAccountPage.given.cancel_my_account
end

When /^I confirm action$/ do
  EditAccountPage.accept_alert
end
