#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^opened article '(.*)' page$/ do |article_title|
  HomePage.given.view_article article_title
end

####################################
#              CHECKS              #
####################################

Then /^I see comment displayed on (.*) page:$/ do |page, table|
  expect(page.given.comment_data).to eql(table.rows_hash.symbolize_keys)
end