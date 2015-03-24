@wip
Feature: Account Editing
  As a user 
  I want to edit my account
  So I can change my name, password and email

  Background:
    Given registered user with parameters:
      | user_name | UNIQ_USER[:full_name]  |
      | email     | UNIQ_USER[:email]      |
      | password  | UNIQ_USER[:password]   |
    And Edit account page of web application for UNIQ_USER[:email] user

  Scenario: user can edit password and name with correct credentials
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER2[:full_name] |
      | email                  | UNIQ_USER[:email]      |
      | password               | UNIQ_USER2[:password]  |
      | password confirmation  | UNIQ_USER2[:password]  |
      | current password       | UNIQ_USER[:password]   |
    And I submit 'Edit account' form on Edit account page
    Then I should see following text on Home page:
      """
      You updated your account successfully.
      """
    When I fill Login form on Login page with data:
      | email                  | UNIQ_USER[:email]      |
      | password               | UNIQ_USER2[:password]  |
    And I submit Login form on Login page
    Then I should be logged in the system
    And I should be redirected to Home page
    And I should see 'Edit account' form on Edit account page with parameters
      | user_name              | UNIQ_USER2[:full_name] |
      | email                  | UNIQ_USER[:email]      |
      | password               |                        |
      | password confirmation  |                        |
      | current password       |                        |

  Scenario: user can edit email with correct credentials
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER[:full_name]  |
      | email                  | UNIQ_USER2[:email]     |
      | password               |                        |
      | password confirmation  |                        |
      | current password       | UNIQ_USER[:password]   |
    And I submit 'Edit account' form on Edit account page
    Then I should see following text on Home page:
      """
      You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address.
      """
    When I confirm UNIQ_USER2[:email] account from confirmation instruction email
    Then I should see following text on Login page:
      """
      Your account was successfully confirmed.
      """
    When I fill Login form on Login page with data:
      | email                  | UNIQ_USER2[:email]     |
      | password               | UNIQ_USER[:password]   |
    And I submit Login form on Login page
    Then I should be logged in the system
    And I should see following text on Home page:
      """
      Signed in successfully.
      """
      
  Scenario: user can not edit account with incorrect email
    Given registered user with parameters:
      | user_name              | UNIQ_USER1[:full_name] |
      | email                  | UNIQ_USER1[:email]     |
      | password               | UNIQ_USER1[:password]  |
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER[:full_name]  |
      | email                  | test.1234567890        |
      | password               |                        |
      | password confirmation  |                        |
      | current password       |                        |
    Then I should see following text on Edit account page:
      """
      Необходимо ввести допустимый адрес электронной почты
      """
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER1[:email]    |
      | password               |                       |
      | password confirmation  |                       |
      | current password       | UNIQ_USER[:password]  |
    And I submit 'Edit account' form on Edit account page
    Then I should see following text on Edit account page:
      """
      1 error prohibited this user from being saved:
      •Email has already been taken
      """

  Scenario: user can not edit account with incorrect password 
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | UNIQ_USER2[:password] |
      | password confirmation  | UNIQ_USER2[:password] |
      | current password       | UNIQ_USER2[:password] |
    And I submit 'Edit account' form on Edit account page
    Then I should see following text on Edit account page:
      """
      1 error prohibited this user from being saved:
      •Current password is invalid
      """
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | 12345678              |
      | password confirmation  | 123456789             |
      | current password       | UNIQ_USER[:password]  |
    And I submit 'Edit account' form on Edit account page
    Then I should see following text on Edit account page:
      """
      1 error prohibited this user from being saved:
      •Password confirmation doesn't match Password
      """
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | 1234567               |
      | password confirmation  | 1234567               |
      | current password       | UNIQ_USER[:password]  |
    And I submit 'Edit account' form on Edit account page
    Then I should see following text on Edit account page:
      """
      1 error prohibited this user from being saved:
      •Password is too short (minimum is 8 characters)
      """
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | 1234567               |
      | password confirmation  | 1234567               |
      | current password       | UNIQ_USER2[:password] |
    And I submit 'Edit account' form on Edit account page
    Then I should see following text on Edit account page:
      """
      2 errors prohibited this user from being saved:
      •Password is too short (minimum is 8 characters)
      •Current password is invalid
      """

  Scenario: user can not edit account with incorrect email and password
    Given registered user with parameters:
      | user_name              | UNIQ_USER1[:full_name] |
      | email                  | UNIQ_USER1[:email]     |
      | password               | UNIQ_USER1[:password]  |
    When I fill 'Edit account' form on Edit account page with data:
      | user_name              | UNIQ_USER[:full_name]  |
      | email                  | UNIQ_USER1[:email]     |
      | password               | 1234567                |
      | password confirmation  | 1234567                |
      | current password       | UNIQ_USER2[:password]  |
    And I submit 'Edit account' form on Edit account page
    Then I should see following text on Edit account page:
      """
      3 errors prohibited this user from being saved:
      •Email has already been taken
      •Password confirmation doesn't match Password
      •Password is too short (minimum is 8 characters)
      """