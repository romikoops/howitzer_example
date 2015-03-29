#############################################################
#                      ACTIONS                              #
#############################################################
When /^I cancel account on Edit account page$/ do
  EditAccountPage.given.cancel_my_account
end

When /^I confirm account cancelling$/ do
  EditAccountPage.accept_alert
end
