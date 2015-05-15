#############################################################
#                      ACTIONS                              #
#############################################################
When /^I cancel account on edit account page$/ do
  EditAccountPage.given.cancel_my_account
end

####################################
#              CHECKS              #
####################################
Then(/^I should see form data on edit account page:$/) do |table|
  expect(EditAccountPage.given.form_data).to eq(table.rows_hash.symbolize_keys)
end