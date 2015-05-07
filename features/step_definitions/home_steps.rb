####################################
#              CHECKS              #
####################################
Then /^I should see (.+) form on home page with data:$/ do |date, table|
  article = table.rows_hash.symbolize_keys
  expect(HomePage.given.find_form_text(date)).to include(article[:creation_time])
  expect(HomePage.given.find_form_text(date)).to include(article[:article_title])
end