
####################################
#              ACTIONS             #
####################################

When /^I confirm (.+) resetting password from (.+) email$/ do |recipient, email|
  email.as_email_class.find_by_recipient(recipient).confirm_my_account
end

####################################
#              CHECKS              #
####################################


Then /^I should see (.+) page$/ do |page|
  page.given
end
