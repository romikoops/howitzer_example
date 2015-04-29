#############################################################
#                      PREREQUISITES                        #
#############################################################

Given /^opened article '(.*)' page$/ do |article_title|
  HomePage.given.view_article article_title
end

And /^article with parameters:$/ do |table|
  steps %Q{
    And I open articles list page
    When I click new article button on articles list page
And I fill form on new article page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I submit form on new article page
        }
end

#############################################################
#                      ACTIONS                              #
#############################################################

When /^I click new article button on articles list page$/ do
  ArticlesListPage.given.add_new_article
end

When /^I click Destroy button on article UNIQ_ARTICLE\[:title\] on articles list page$/ do
  title=Gen::given_article_by_number(0).title
  ArticlesListPage.given.destroy_article(title)
end

And /^I confirm action$/ do
  ArticlesListPage.accept_alert
end

And /^I don't confirm action$/ do
  page.driver.browser.switch_to.alert.dismiss
end

####################################
#              CHECKS              #
####################################

Then /^I see comment displayed on (.*) page:$/ do |page, table|
  expect(page.given.comment_data).to eql(table.rows_hash.symbolize_keys)
end

Then /^I should see article on (.+) page with data:$/ do |page, table|
  article = table.rows_hash.symbolize_keys
  expect(page.given.text).to include(article[:title])
  expect(page.given.text).to include(article[:text])
end

Then /^I should not see article on (.+) page with data:$/ do |page, table|
  article = table.rows_hash.symbolize_keys
  expect(page.given.text).to_not include(article[:title])
  expect(page.given.text).to_not include(article[:text])
end