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
 NewArticlePage.given.fill_form("as",'sd')

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