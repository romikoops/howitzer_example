@ok
Feature: Sign Up
  As a user 
  I want to sign up to the system
  So I can login with a new account
  
  @bvt
  Scenario: user can open Sign up page via menu
    Given Home page of web application
    When I click Sign up menu item on Home page
    Then I should be redirected to Sign up page

  @bvt
  Scenario: visitor can initiate sign up
    Given Login page of web application
    When I click Sign up menu item on Login page
    Then I should be redirected to Sign up page

  @bvt
  Scenario: user can sign up with correct credentials
    Given Sign up page of web application
    When I fill Sign up form on Sign up page with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
      | password_confirmation | UNIQ_USER[:password]  |
    And I submit Sign up form on Sign up page
    Then I should not be logged to the system
    And I should see following text on Home page:
      """
      A message with a confirmation link has been sent to your email address. Please open the link to activate your account.
      """
    And I should receive confirmation instruction email for UNIQ_USER[:email] recipient
    When I confirm UNIQ_USER[:email] account from confirmation instruction email
    Then I should see following text on Login page:
      """
      Your account was successfully confirmed.
      """
    When I fill Login form on Login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit Login form on Login page
    Then I should be logged in the system
    And I should be redirected to Home page

  @p1
  Scenario: user can not sign up with blank data
    Given Sign up page of web application
    When I fill Sign up form on Sign up page with data:
      | user_name             |         |
      | email                 |         |
      | password              |         |
      | password_confirmation |         |
    And I submit Sign up form on Sign up page
    Then I should not be logged in the system
    And I should see following text on Sign up page:
      """
      2 errors prohibited this user from being saved:
      •Email can't be blank
      •Password can't be blank
      """
    When I fill Sign up form on Sign up page with data:
      | user_name             |                      |
      | email                 | UNIQ_USER[:email]    |
      | password              |                      |
      | password_confirmation |                      |
    And I submit Sign up form on Sign up page
    Then I should not be logged in the system
    And I should see following text on Sign up page:
      """
      1 error prohibited this user from being saved:
      •Password can't be blank
      """
    When I fill Sign up form on Sign up page with data:
      | user_name             |                      |
      | email                 |                      |
      | password              | UNIQ_USER[:password] |
      | password_confirmation | UNIQ_USER[:password] |
    And I submit Sign up form on Sign up page
    Then I should not be logged in the system
    And I should see following text on Sign up page:
      """
      1 error prohibited this user from being saved:
      •Email can't be blank
      """

  @p1
  Scenario: user can not sign up with incorrect data
    Given Sign up page of web application
    When I fill Sign up form on Sign up page with data:
      | user_name             |                      |
      | email                 | test.1234567890      |
      | password              |                      |
      | password_confirmation |                      |
    Then I should see following text on Sign up page:
      """
      Необходимо ввести допустимый адрес электронной почты
      """
    When I fill Sign up form on Sign up page with data:
      | user_name             |                      |
      | email                 | UNIQ_USER[:email]    |
      | password              | 1234567              |
      | password_confirmation | 1234567              |
    And I submit Sign up form on Sign up page
    Then I should not be logged in the system
    And I should see following text on Sign up page:
      """
      1 error prohibited this user from being saved:
      •Password is too short (minimum is 8 characters)
      """
    When I fill Sign up form on Sign up page with data:
      | user_name             |                      |
      | email                 | UNIQ_USER[:email]    |
      | password              | 1234567890           |
      | password_confirmation | 1234567890123        |
    And I submit Sign up form on Sign up page
    Then I should not be logged in the system
    And I should see following text on Sign up page:
      """
      1 error prohibited this user from being saved:
      •Password confirmation doesn't match Password
      """

  @p1
  Scenario: user can not sign up with duplicated email
    Given registered user with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
    And Sign up page of web application
    When I fill Sign up form on Sign up page with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
      | password_confirmation | UNIQ_USER[:password]  |
    And I submit Sign up form on Sign up page
    Then I should not be logged in the system
    And I should see following text on Sign up page:
      """
      1 error prohibited this user from being saved:
      •Email has already been taken
      """