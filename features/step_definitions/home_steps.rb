####################################
#              CHECKS              #
####################################
Then /^I should see today form on home page with data:$/ do |table|
  article = table.rows_hash.symbolize_keys
  expect(HomePage.given.find_form_text('Today')).to include(article[:creation_time])
  expect(HomePage.given.find_form_text('Today')).to include(article[:article_title])
end