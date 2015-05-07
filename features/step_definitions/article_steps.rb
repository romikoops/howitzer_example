#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^opened article '(.*)' page$/ do |article_title|
  HomePage.given.view_article article_title
end

Given /^there is article with parameters:$/ do |table|
  step "I open articles list page"
  step "I click new article button on articles list page"
  step "I fill form on new article page with data:", table
  step "I submit form on new article page"
end

#############################################################
#                      ACTIONS                              #
#############################################################

When /^I click new article button on articles list page$/ do
  ArticleListPage.given.add_new_article
end

When /^I destroy (.+) article on articles list page$/ do |title|
  ArticlesListPage.given.destroy_article(title)
end

When /^I confirm destroy action$/ do
  WebPage.accept_js_alert
end

When /^I don't confirm destroy action$/ do
  WebPage.dismiss_js_alert
end

####################################
#              CHECKS              #
####################################

Then /^I see comment displayed on (.*) page:$/ do |page, table|
  expect(page.given.comment_data).to eql(table.rows_hash.symbolize_keys)
end

Then /^I should see (.+) article on articles list page$/ do |title|
  expect(ArticlesListPage.given.text).to include(title)
end

Then /^I should not see (.+) article on articles list page$/ do |title|
  expect(ArticlesListPage.given.text).to_not include(title)
end
