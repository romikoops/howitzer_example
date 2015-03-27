####################################
#              ACTIONS             #
####################################
When /^I submit Sign up form on Sign up page$/ do
  SignUpPage.given.submit_form
end
