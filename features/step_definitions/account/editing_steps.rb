#############################################################
#                      PREREQUISITES                        #
#############################################################

Given(/^edit account page of web application for (.+) user$/) do |email|
  HomePage.given.choose_menu('Edit account')
end

####################################
#              CHECKS              #
####################################

Then(/^I logged out on system$/) do
  HomePage.given.choose_menu('Logout')
end

Then(/^I go to login page$/) do
  HomePage.given.choose_menu('Login')
end

Then(/^I should see 'Edit account' form on (.+) page with parameters$/) do |page, table|
  step "edit account page of web application for (.+) user"
  page.given.fill_form(table.rows_hash.symbolize_keys)
end




