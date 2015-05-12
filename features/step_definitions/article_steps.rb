#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^opened article '(.*)' page$/ do |article_title|
  HomePage.given.view_article article_title
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

Given /^there is comment in (.+) article with parameter:$/ do |article,table|
  step "I am logged in as admin user"
  step "I open article list page"
  step "I click new article button on article list page"
  step "I fill form on new article page with data:", table
  step "I submit form on new article page"
  step "I fill new comment form on article page with data:",table
  step "I submit new comment form on article page"
end

Given /^opened (.+) article page$/ do |article|
  ArticleListPage.open
  ArticleListPage.given.open_article(article)
end

Given /^comment to (.+) article with parameter:$/ do |article,table|
  step "I open article list page"
  ArticleListPage.given.open_article(article)
  step "I fill new comment form on article page with data:",table
  step "I submit new comment form on article page"
end
#############################################################
#                      ACTIONS                              #
#############################################################

When /^I click new article button on article list page$/ do
  ArticleListPage.given.add_new_article
end

When /^I destroy with(out)? confirmation (.+) article on article list page$/ do |option, title|
  confirmation = false ? true : option != 'out'
  ArticleListPage.given.destroy_article(title, confirmation)
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

When /^I open article page for (.+)$/ do |article|
  ArticleListPage.open
  ArticleListPage.given.open_article(article)
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

Then /^I should see (.+) user comment on (.+) page with data:$/ do |user, page, table|
  comment = table.rows_hash.symbolize_keys
  if user=="admin" then
    expect(page.given.text).to include(settings.def_test_user)
  else
    expect(page.given.text).to include(comment[:commenter])
  end
  expect(page.given.text).to include(comment[:comment])
end

Then /^I should see add comment form on article page$/ do
  ArticlePage.given.comment_form_present.should be_visible
end

Then /^I should see body field on article page$/ do
  ArticlePage.given.body_field_present.should be_visible
end

Then /^I should see buttons: edit article, destroy comment, create comment on article page$/ do
  ArticlePage.given.admin_buttons_present.should be_visible
end