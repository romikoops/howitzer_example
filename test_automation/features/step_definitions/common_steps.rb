#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^(.+) page of web application$/ do |page|
  page.as_page_class.open
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

####################################
#              CHECKS              #
####################################

Then /^(.+) page should be displayed$/ do |page|
  page.given
end

Then /^I should be logged in the system$/ do
  expect(HomePage).to be_authenticated
end