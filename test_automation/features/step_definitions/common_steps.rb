#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^(.+) page of web application$/ do |page|
  page.open
end

####################################
#              ACTIONS             #
####################################

When /^I click (.+?) menu item on (.+) page$/ do |text, page|
  page.given.choose_menu(text)
end

When /^I fill form data on (.+) page:$/ do |page, table|
  page.given.fill_form(table.rows_hash.symbolize_keys)
end

When /^I submit form on (.+) page$/ do |page|
  page.given.submit_form
end

When /^I confirm (.+) account from (.+) email$/ do |recipient, email|
  email.as_email_class.find_by_recipient(recipient).confirm_my_account
end

####################################
#              CHECKS              #
####################################

Then /^(.+) page should be displayed$/ do |page|
  page.given
end

Then /^I should be logged in the system$/ do
  expect(HomePage).to be_authenticated
end

Then /^I should not be logged in the system$/ do
  expect(HomePage).to_not be_authenticated
end

Then /^I see following text on (.+) page:$/ do |page, text|
  expect(page.given.text).to include(text)
end

Then /^I should receive (.+) email for (.+) recipient$/ do |email, recipient|
  email.as_email_class.find_by_recipient(recipient)
end