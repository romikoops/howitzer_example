####################################
#              CHECKS              #
####################################
Then(/^I should see form data on edit account page:$/) do |table|
  expect(EditAccountPage.given.form_data).to eq(table.rows_hash.symbolize_keys)
end