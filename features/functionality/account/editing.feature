Feature: Account Editing
  As a user
  I want to edit my account
  So I can change my name, password and email

  Scenario: user can edit password and name with correct credentials
    Given there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user
    And I am on edit account page
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER1[:full_name] |
      | password               | UNIQ_USER1[:password]  |
      | password_confirmation  | UNIQ_USER1[:password]  |
      | current_password       | UNIQ_USER[:password]   |
    And I submit form on edit account page
    Then I should see following text on home page:
      """
      You updated your account successfully.
      """
    When I log out
    Then I should not be logged in the system
    When I open login page
    And I fill form on login page with data:
      | email                  | UNIQ_USER[:email]      |
      | password               | UNIQ_USER1[:password]  |
    And I submit form on login page
    Then I should be logged in the system
    When I open edit account page
    Then I should see form data on edit account page:
      | user_name              | UNIQ_USER1[:full_name] |
      | email                  | UNIQ_USER[:email]      |
      | password               |                        |
      | password_confirmation  |                        |
      | current_password       |                        |

  Scenario: user can edit email with correct credentials
    Given there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user
    And I am on edit account page
    When I fill form on edit account page with data:
      | user_name              | UNIQ_USER[:full_name]  |
      | email                  | UNIQ_USER1[:email]     |
      | password               |                        |
      | password_confirmation  |                        |
      | current_password       | UNIQ_USER[:password]   |
    And I submit form on edit account page
    Then I should see following text on home page:
      """
      You updated your account successfully, but we need to verify your new email address. Please check your email and click on the confirm link to finalize confirming your new email address.
      """
    When I confirm UNIQ_USER1[:email] account from confirmation instruction email
    Then I should see following text on home page:
      """
      Your account was successfully confirmed.
      """
    When I log out
    Then I should not be logged in the system
    When I open login page
    And I fill form on login page with data:
      | email                  | UNIQ_USER1[:email]     |
      | password               | UNIQ_USER[:password]   |
    And I submit form on login page
    Then I should be logged in the system
    And I should see following text on home page:
      """
      Signed in successfully.
      """

  Scenario: user can not edit account with incorrect email
    Given there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user
    And I am on edit account page
    When I fill form on edit account page with data:
      | email                  | test@.ua               |
      | current_password       | UNIQ_USER[:password]   |
    And I submit form on edit account page
    Then edit account page should be displayed

  Scenario: user can not edit account with existing email
    Given there is registered UNIQ_USER user
    And there is registered UNIQ_USER1 user
    And I am logged in as UNIQ_USER1 user
    And I am on edit account page
    When I fill form on edit account page with data:
      | email                  | UNIQ_USER[:email] |
      | current_password       | UNIQ_USER1[:password]  |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Email has already been taken
      """

  Scenario: user can not edit account with incorrect password
    Given there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user
    And I am on edit account page
    When I fill form on edit account page with data:
      | password               | UNIQ_USER1[:password] |
      | password_confirmation  | UNIQ_USER1[:password] |
      | current_password       | incorrect_password    |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Current password is invalid
      """

  Scenario: user can not edit account with incorrect password confirmation
    Given there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user
    And I am on edit account page
    When I fill form on edit account page with data:
      | password               | 12345678              |
      | password_confirmation  | 123456789             |
      | current_password       | UNIQ_USER[:password]  |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Password confirmation doesn't match Password
      """

  Scenario: user can not edit account with short password (less then 8 characters)
    Given there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user
    And I am on edit account page
    When I fill form on edit account page with data:
      | password               | 1234567               |
      | password_confirmation  | 1234567               |
      | current_password       | UNIQ_USER[:password]  |
    And I submit form on edit account page
    Then I should see following text on edit account page:
      """
      1 error prohibited this user from being saved: Password is too short (minimum is 8 characters)
      """