@wip
Feature: Users List
  As a user 
  I want to see users registered in system
  So I can see Users list

  Background:
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name]  |
      | email     | UNIQ_USER[:email]      |
      | password  | UNIQ_USER[:password]   |
    And registered admin user with parameters:
      | user_name | UNIQ_USER1[:full_name] |
      | email     | UNIQ_USER1[:email]     |
      | password  | UNIQ_USER1[:password]  |
    And I logged as UNIQ_USER[:email] user

  Scenario: user is viewing users in Users list
    When I click Users menu item
    Then I should see Users list page with data:
      | user_data | UNIQ_USER[:email] signed up UNIQ_USER[:registration_date]   |
      | user_data | UNIQ_USER1[:email] signed up UNIQ_USER1[:registration_date] |