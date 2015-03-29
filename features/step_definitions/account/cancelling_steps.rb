#############################################################
#                      ACTIONS                              #
#############################################################
When /^I cancel account on edit account page$/ do
  EditAccountPage.given.cancel_my_account
end

When /^I confirm account cancelling on edit account page$/ do
  EditAccountPage.accept_alert
end
