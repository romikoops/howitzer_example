####################################
#              ACTIONS             #
####################################
When /^I submit sign up form on sign up page$/ do
  SignUpPage.given.submit_form
end
