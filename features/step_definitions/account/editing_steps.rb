#############################################################
#                      PREREQUISITES                        #
#############################################################
Given /^I am on edit account page$/ do
  EditAccountPage.open
end

####################################
#              CHECKS              #
####################################
Then(/^I should see form data on edit account page:$/) do |table|
  expecte(EditAccountPage).to be_filled_right(table.rows_hash.symbolize_keys)
end