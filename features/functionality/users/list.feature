Feature: Users List
  As a user 
  I want to see users registered in system
  So I can see Users list

  Scenario: user is viewing users in Users list
    Given there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user
    When I navigate to users list via main menu
    Then I should see UNIQ_USER[:email] signed up on today's date