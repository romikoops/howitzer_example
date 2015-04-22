#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^opened article '(.*)' page$/ do |article_title|
  HomePage.given.view_article article_title
end
#############################################################
#                      ACTIONS                              #
#############################################################

When /^I click new article button on articles list page$/ do
  ArticlesListPage.given.add_new_article
end

####################################
#              CHECKS              #
####################################

Then /^I see comment displayed on (.*) page:$/ do |page, table|
  expect(page.given.comment_data).to eql(table.rows_hash.symbolize_keys)
end

Then /^I should see article on (.+) page with data:$/ do |page, table|
  article = table.rows_hash.symbolize_keys
 expect(page.given.text).to include(article[:title]) and expect(page.given.text).to include(article[:text])
end

