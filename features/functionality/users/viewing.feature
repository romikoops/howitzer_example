Feature: User Viewing
  As a user
  I want to view other user registered in system
  So I can see data of other user registered in system

  Background:
    Given registered user with parameters:
      | user_name | UNIQ_USER[:full_name]  |
      | email     | UNIQ_USER[:email]      |
      | password  | UNIQ_USER[:password]   |
    And registered user with parameters:
      | user_name | UNIQ_USER1[:full_name] |
      | email     | UNIQ_USER1[:email]     |
      | password  | UNIQ_USER1[:password]  |
    And I logged as UNIQ_USER[:email] user
    And opened Users page

  Scenario: user is viewing other user on User page
    When I click on UNIQ_USER1[:email] link on Users page
    Then I should see UNIQ_USER1[:email] user page with data:
      | user_data | Email: UNIQ_USER1[:email] |