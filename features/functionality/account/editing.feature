Feature: Account Editing
  As a user
  I want to edit my account
  So I can change my name, password and email

  Background:
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name]  |
      | email     | UNIQ_USER[:email]      |
      | password  | UNIQ_USER[:password]   |
    And I fill form on login page with data:
      | email                  | UNIQ_USER[:email]     |
      | password               | UNIQ_USER[:password]  |
    And I submit form on login page
    And edit account page of web application for UNIQ_USER[:email] user

  Scenario: user can edit password and name with correct credentials
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER2[:full_name] |
      | email                  | UNIQ_USER[:email]      |
      | password               | UNIQ_USER2[:password]  |
      | password_confirmation  | UNIQ_USER2[:password]  |
      | current_password       | UNIQ_USER[:password]   |
    And I submit form on edit account page
    Then I should see following text on home page:
      """
      You updated your account successfully.
      """
    And I logged out on system
    And I go to login page

    When I fill form on login page with data:
      | email                  | UNIQ_USER[:email]      |
      | password               | UNIQ_USER2[:password]  |
    And I submit form on login page
    Then I should be logged in the system
    And I should see 'Edit account' form on edit account page with parameters
      | user_name              | UNIQ_USER2[:full_name] |
      | email                  | UNIQ_USER[:email]      |
      | password               |                        |
      | password_confirmation  |                        |
      | current_password       |                        |

  Scenario: user can edit email with correct credentials
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name]  |
      | email                  | UNIQ_USER2[:email]     |
      | password               |                        |
      | password_confirmation  |                        |
      | current_password       | UNIQ_USER[:password]   |
    And I submit form on edit account page
    Then I should see following text on home page:
      """
      You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address.
      """
    When I confirm UNIQ_USER2[:email] account from confirmation instruction email
    Then I should see following text on home page:
      """
      Your account was successfully confirmed.
      """
    And I logged out on system
    And I go to login page

    When I fill form on login page with data:
      | email                  | UNIQ_USER2[:email]     |
      | password               | UNIQ_USER[:password]   |
    And I submit form on login page
    Then I should be logged in the system
    And I should see following text on home page:
      """
      Signed in successfully.
      """

  Scenario: user can not edit account with incorrect email
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name]  |
      | email                  | test@i.ua              |
      | password               |                        |
      | password_confirmation  |                        |
      | current_password       |                        |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Current password can't be blank
      """
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | chagrin2013@gmail.com |
      | password               |                       |
      | password_confirmation  |                       |
      | current_password       | UNIQ_USER[:password]  |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Email has already been taken
      """

  Scenario: user can not edit account with incorrect password
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | UNIQ_USER2[:password] |
      | password_confirmation  | UNIQ_USER2[:password] |
      | current_password       | 123456789             |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Current password is invalid
      """
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | 12345678              |
      | password_confirmation  | 123456789             |
      | current_password       | UNIQ_USER[:password]  |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Password confirmation doesn't match Password
      """
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | 1234567               |
      | password_confirmation  | 1234567               |
      | current_password       | UNIQ_USER[:password]  |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Password is too short (minimum is 8 characters)
      """
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | 1234567               |
      | password_confirmation  | 1234567               |
      | current_password       | 123456789             |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      2 errors prohibited this user from being saved: Password is too short (minimum is 8 characters) Current password is invalid
      """

  Scenario: user can not edit account with incorrect email and password
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name]  |
      | email                  | chagrin2013@gmail.com  |
      | password               | 1234567                |
      | password_confirmation  | 12345678               |
      | current_password       | UNIQ_USER[:password]   |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      3 errors prohibited this user from being saved: Email has already been taken Password confirmation doesn't match Password Password is too short (minimum is 8 characters)
      """