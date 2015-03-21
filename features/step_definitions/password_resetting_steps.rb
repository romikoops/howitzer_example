#############################################################
#                      PREREQUISITES                        #
#############################################################

Given(/^registered user with data:$/) do |table|
  step "Sign up page of web application"
  step "I fill Sign up form on Sign up page with data:", table(%{
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

When(/^I click 'Forgot password' link on Login page$/) do
  LoginPage.given.forgot_password
end

And(/^I fill 'Forgot password' form on Forgot password page with data:$/) do |table|
  art = table.rows_hash
  ForgotPasswordPage.given.fill_email(art['email'])
end

And(/^I submit 'Forgot password' form on Forgot password page$/) do
  ForgotPasswordPage.given.submit_form
end

And(/^I fill 'Change password' form on Change password page with data:$/) do |table|
  ChangePasswordPage.given.fill_form(table.rows_hash['new password'],table.rows_hash['confirm new password'])
end

####################################
#              CHECKS              #
####################################

Then(/^I should see following text on Login page:$/) do |string|
  LoginPage.has_text?(string)
end
