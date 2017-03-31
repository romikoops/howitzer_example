#############################################################
#                      PREREQUISITES                        #
#############################################################


####################################
#              ACTIONS             #
####################################

When(/^I click on (.+) user email on users page$/) do |email|
  UsersPage.given.open_user(email)
end

####################################
#              CHECKS              #
####################################
