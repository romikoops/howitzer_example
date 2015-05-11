#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^opened article '(.*)' page$/ do |article_title|
  HomePage.given.view_article article_title
end

And /^comment for UNIQ_ARTICLE\[:title\] article with parameter:$/ do |table|
step "I fill new comment form on article page with data:", table
step "I submit new comment form on article page"
end

Given /^there is article with parameters:$/ do |table|
  step "I open article list page"
  step "I click new article button on article list page"
  step "I fill form on new article page with data:", table
  step "I submit form on new article page"
end

Given /^there is (.+) article:$/ do |article,table|
  step "I am logged in as admin user"
  step "I open article list page"
  step "I click new article button on article list page"
  step "I fill form on new article page with data:", table
  step "I submit form on new article page"
  step 'user logged out'
end

Given /^opened (.+) article page$/ do |article|
  ArticleListPage.open
  ArticleListPage.given.open_article(article)
end

#############################################################
#                      ACTIONS                              #
#############################################################

When /^I click new article button on article list page$/ do
  ArticleListPage.given.add_new_article
end

When /^I destroy (.+) article on article list page$/ do |title|
  ArticleListPage.given.destroy_article(title)
end

When /^I confirm destroy action$/ do
  WebPage.accept_js_alert
end

When /^I don't confirm destroy action$/ do
  WebPage.dismiss_js_alert
end

When /^I click (.+) article on article list page$/ do |article|
  ArticleListPage.given.open_article(article)
end

When /^I fill new comment form on article page with data:$/ do |table|
  ArticlePage.given.fill_form(table.rows_hash.symbolize_keys)
end

When /^I fill new comment form on article page with blank data:$/ do |table|
  ArticlePage.given.fill_form(table.rows_hash.symbolize_keys)
end

When /^I submit new comment form on article page$/ do
  ArticlePage.given.submit_form
end

When /^I destroy (.+) comment on article page$/ do |comment_text|
  ArticlePage.given.destroy_comment(comment_text)
end

####################################
#              CHECKS              #
####################################
Then /^I see comment displayed on (.*) page:$/ do |page, table|
  expect(page.given.comment_data).to eql(table.rows_hash.symbolize_keys)
end

Then /^I should see (.+) article on article list page$/ do |title|
  expect(ArticleListPage.given.text).to include(title)
end

Then /^I should not see (.+) article on article list page$/ do |title|
  expect(ArticleListPage.given.text).to_not include(title)
end

Then /^I should not see comment on (.+) page with data:$/ do |page, table|
  comment = table.rows_hash.symbolize_keys
  expect(page.given.text).to_not include(comment[:body])
end

Then /^I should see comment on (.+) page with data:$/ do |page, table|
  comment = table.rows_hash.symbolize_keys
  expect(page.given.text).to include(comment[:commenter])
  expect(page.given.text).to include(comment[:body])
end
