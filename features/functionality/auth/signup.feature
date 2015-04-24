Feature: Sign Up
  As a user 
  I want to sign up to the system
  So I can login with a new account
  
  Scenario: user can open sign up page via menu
    Given home page of web application
    When I click Sign up menu item on home page
    Then I should be redirected to sign up page

  Scenario: visitor can initiate sign up
    Given login page of web application
    When I click Sign up menu item on login page
    Then I should be redirected to sign up page

  Scenario: user can sign up with correct credentials
    Given sign up page of web application
    When I fill form on sign up page with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
      | password_confirmation | UNIQ_USER[:password]  |
    And I submit sign up form on sign up page
    Then I should not be logged in the system
    And I should see following text on home page:
      """
      A message with a confirmation link has been sent to your email address. Please open the link to activate your account.
      """
    And I should receive confirmation instruction email for UNIQ_USER[:email] recipient
    When I confirm UNIQ_USER[:email] account from confirmation instruction email
    Then I should see following text on login page:
      """
      Your account was successfully confirmed.
      """
    When I fill form on login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit form on login page
    Then I should be logged in the system
    And I should be redirected to home page

  Scenario: user can not sign up with blank data
    Given sign up page of web application
    When I fill form on sign up page with data:
      | user_name             |         |
      | email                 |         |
      | password              |         |
      | password_confirmation |         |
    And I submit sign up form on sign up page
    Then I should not be logged in the system
    And I should see following text on sign up page:
    """
    2 errors prohibited this user from being saved: Email can't be blank Password can't be blank
    """
    When I fill form on sign up page with data:
      | user_name             |                      |
      | email                 | UNIQ_USER[:email]    |
      | password              |                      |
      | password_confirmation |                      |
    And I submit sign up form on sign up page
    Then I should not be logged in the system
    And I should see following text on sign up page:
    """
    1 error prohibited this user from being saved: Password can't be blank
    """
    When I fill form on sign up page with data:
      | user_name             |                      |
      | email                 |                      |
      | password              | UNIQ_USER[:password] |
      | password_confirmation | UNIQ_USER[:password] |
    And I submit sign up form on sign up page
    Then I should not be logged in the system
    And I should see following text on sign up page:
    """
    1 error prohibited this user from being saved: Email can't be blank
    """

  Scenario: user can not sign up with incorrect data
    Given sign up page of web application
    When I fill form on sign up page with data:
      | user_name             |                      |
      | email                 | test.1234567890      |
      | password              |                      |
      | password_confirmation |                      |
    Then I should not be logged in the system
    When I fill form on sign up page with data:
      | user_name             |                      |
      | email                 | UNIQ_USER[:email]    |
      | password              | 1234567              |
      | password_confirmation | 1234567              |
    And I submit sign up form on sign up page
    Then I should not be logged in the system
    And I should see following text on sign up page:
     """
     1 error prohibited this user from being saved: Password is too short (minimum is 8 characters)
     """
    When I fill form on sign up page with data:
      | user_name             |                      |
      | email                 | UNIQ_USER[:email]    |
      | password              | 1234567890           |
      | password_confirmation | 1234567890123        |
    And I submit sign up form on sign up page
    Then I should not be logged in the system
    And I should see following text on sign up page:
     """
     1 error prohibited this user from being saved: Password confirmation doesn't match Password
     """

  @p1
  Scenario: user cannot sign up with duplicated email
    Given there is registered UNIQ_USER user
    And sign up page of web application
    When I fill form on sign up page with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
      | password_confirmation | UNIQ_USER[:password]  |
    And I submit sign up form on sign up page
    Then I should not be logged in the system
    And I should see following text on sign up page:
    """
    1 error prohibited this user from being saved: Email has already been taken
    """
