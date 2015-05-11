#############################################################
#                      ACTIONS                              #
#############################################################
When /^I cancel account on edit account page$/ do
  EditAccountPage.given.cancel_my_account
end
