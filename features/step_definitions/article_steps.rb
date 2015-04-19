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

And /^I fill new article form on new article page with data:$/ do |table|
 article = table.rows_hash.symbolize_keys
  NewArticlePage.given.fill_form(article[:title], article[:text])

end

And /^I submit new article form on new article page$/ do
  NewArticlePage.given.submit_form
end


####################################
#              CHECKS              #
####################################

Then /^I see comment displayed on (.*) page:$/ do |page, table|
  expect(page.given.comment_data).to eql(table.rows_hash.symbolize_keys)
end

Then /^I should see article parameters on article page with data:$/ do |table|
  article = table.rows_hash.symbolize_keys
 (expect(ArticlePage.given.text).to include(article[:title]) and expect(ArticlePage.given.text).to include(article[:text]))
end

Then(/^I should see article on articles list page with data:$/) do |table|
  article = table.rows_hash.symbolize_keys
  ArticlesListPage.open
  (expect(ArticlesListPage.given.text).to include(article[:title]) and expect(ArticlesListPage.given.text).to include(article[:text]))
end
