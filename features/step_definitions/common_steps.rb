#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^opened browser$/ do
  BlankPage.instance
end

Given /^(.+) page of web application$/ do |page|
  page.open
end

Given /^registered user with parameters$/ do |table|
  user = table.rows_hash.symbolize_keys
  #TODO add user creation
  LoginPage.open.login_as(user[:email], user[:password])
end

Given /^article with parameters$/ do |table|
  article = table.rows_hash.symbolize_keys
  #TODO add article creation
end

Given(/^registered user with data:$/) do |table|
  step "Sign up page of web application"
  step "I fill form data on Sign up page:", table(%{
  | user_name             | UNIQ_USER[:full_name] |
  | email                 | UNIQ_USER[:email]     |
  | password              | UNIQ_USER[:password]  |
  | password_confirmation | UNIQ_USER[:password]  |})
  step "I submit form on Sign up page"
  step "I should not be logged in the system"
  step "I see following text on Home page:", "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
  step "I should receive confirmation instruction email for UNIQ_USER[:email] recipient"
  step "I confirm UNIQ_USER[:email] account from confirmation instruction email"
  step "I see following text on Login page:","Your account was successfully confirmed."
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

When /^I fill form data on (.+) page:$/ do |page, table|
  page.given.fill_form(table.rows_hash.symbolize_keys)
end

When /^I submit form on (.+) page$/ do |page|
  page.given.submit_form
end

When /^I confirm (.+) account from (.+) email$/ do |recipient, email|
  email.as_email_class.find_by_recipient(recipient).confirm_my_account
end

When /^I click (.+) link on (.+) page$/ do |link, page|
  page.given.click_link link
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

Then (/^I should be redirected to (.+) page$/) do |page|
  page.given
end