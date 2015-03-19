#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^opened browser$/ do
  BlankPage.instance
end

Given /^(.+) page of web application$/ do |page|
  page.open
end

Given /^registered user with parameters:$/ do |table|
  user = table.rows_hash.symbolize_keys
  #TODO add user creation
  LoginPage.open.login_as(user[:email], user[:password])
end

Given /^article with parameters$/ do |table|
  article = table.rows_hash.symbolize_keys
  #TODO add article creation
end

####################################
#              ACTIONS             #
####################################

When /^I open (.+?) page$/ do |page|
  page.open
end

When /^I click (.+?) menu item on (.+) page$/ do |text, page|
  page.given.choose_menu(text)
end

When /^I fill (.+) form on (.+) page with data:$/ do |page, table|
  page.given.fill_form(table.rows_hash.symbolize_keys)
end

When /^I submit (.+) form on (.+) page$/ do |page|
  page.given.submit_form
end

When /^I confirm (.+) account from (.+) email$/ do |recipient, email|
  email.as_email_class.find_by_recipient(recipient).confirm_my_account
end

####################################
#              CHECKS              #
####################################

Then /^(.+) page should be displayed$/ do |page|
  page.wait_for_opened
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

Then /^I should be redirected to (.+) page$/ do |page|
  page.wait_for_opened
end