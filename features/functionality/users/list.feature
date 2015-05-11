Feature: Users List
  As a user 
  I want to see users registered in system
  So I can see Users list

  Scenario: user is viewing users in Users list
    Given there is registered UNIQ_USER user
    And there is registered UNIQ_USER2 user logged in system
    When I click 'Users' menu item
    Then I should see UNIQ_USER[:email] signed up on today's date
    And I should see UNIQ_USER2[:email] signed up on today's date