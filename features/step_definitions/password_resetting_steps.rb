
####################################
#              ACTIONS             #
####################################

When /^I confirm (.+) resetting password from (.+) email$/ do |recipient, email|
  email.as_email_class.find_by_recipient(recipient).confirm_my_account
end
