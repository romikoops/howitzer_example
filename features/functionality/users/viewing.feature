@wip
Feature: User Viewing
  As a user
  I want to view other user
  So I can see data of other user

  Background:
    Given user with parameters:
      | user_name | UNIQ_USER[:full_name]  |
      | email     | UNIQ_USER[:email]      |
      | password  | UNIQ_USER[:password]   |
    And user with parameters:
      | user_name | UNIQ_USER1[:full_name] |
      | email     | UNIQ_USER1[:email]     |
      | password  | UNIQ_USER1[:password]  |
    And I logged as UNIQ_USER[:email] user
    And opened user page

  Scenario: user is viewing other user on user page
    When I click on UNIQ_USER1[:email] link on user page
    Then I should see UNIQ_USER1[:email] user page with data:
      | user_data | Email: UNIQ_USER1[:email] |