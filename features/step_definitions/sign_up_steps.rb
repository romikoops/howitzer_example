####################################
#              ACTIONS             #
####################################

When(/^I fill Sign up form on Sign up page with data:$/) do |table|
  art = table.rows_hash
  SignUpPage.given.fill_form(art['user_name'],art['email'],art['password'],art['password_confirmation'])
end

And(/^I submit Sign up form on Sign up page$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I fill Login form on Login page with data:$/) do |table|
  art = table.rows_hash
  LoginPage.given.fill_form(art['email'],art['password'])
end

####################################
#              CHECKS              #
####################################

And(/^I should be redirected to Home page$/) do
  HomePage.given
end