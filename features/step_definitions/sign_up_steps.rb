When /^I submit Sign up form on Sign up page$/ do
  SignUpPage.given.submit_form
end

When /^I fill Sign up form on Sign up page with data:$/ do |table|
  SignUpPage.given.fill_form(table.rows_hash.symbolize_keys)
end