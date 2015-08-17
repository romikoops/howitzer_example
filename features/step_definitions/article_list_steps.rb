When /^I click (.+) article button on article page$/ do |button|
  ArticlePage.given.click_article_button(button)
end

Then /^I should see following article parameters on (.+) page:$/ do |page, table|
  article = table.rows_hash.symbolize_keys
  expect(page.given.text).to include(article[:title])
  expect(page.given.text).to include(article[:text])
end