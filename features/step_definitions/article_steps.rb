#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^I am on (.+) article page$/ do |factory|
  ArticlePage.open(factory.id)
end

Given /^there is (.+) article$/ do |factory|
  factory.save!
end

####################################
#              CHECKS              #
####################################

Then /^I see comment displayed on (.*) page:$/ do |page, table|
  expect(page.given.comment_data).to eql(table.rows_hash.symbolize_keys)
end