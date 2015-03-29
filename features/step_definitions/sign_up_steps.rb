####################################
#              ACTIONS             #
####################################
When /^I submit Sign up form on sign up page$/ do
  SignUpPage.given.submit_form
end
