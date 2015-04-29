Feature: Log In
  As a user 
  I want to use my credentials to login the system
  So I can login the system

  @bvt
  Scenario: user can open login page via menu
    Given home page of web application
    When I click login menu item on home page
    Then login page should be displayed

  @bvt
  Scenario: user can login with correct credentials
    Given there is registered UNIQ_USER user
    And login page of web application
    When I fill form on login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit form on login page
    Then I should be logged in the system
    And I should be redirected to home page

  @bvt @bug
  Scenario: user can login with remembering credentials
    Given there is registered UNIQ_USER user
    And login page of web application
    When I fill form on login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
      | remember_me| yes  |
    And I submit form on login page
    Then I should be logged in the system
    And I should be redirected to home page
    When I click logout menu item on home page
    And I click login menu item on home page
    And I should see following text on login page:
    """
    UNIQ_USER[:email]
    """
    When I submit form on login page
    Then I should be logged in the system
    And I should be redirected to home page

  @p1
  Scenario: user can not login without credentials
    Given there is registered UNIQ_USER user
    And login page of web application
    When I fill form on login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  |                       |
    And I submit form on login page
    Then I should not be logged in the system
    And I should see following text on login page:
      """
      Invalid email or password.
      """
    When I fill form on login page with data:
      | email     |                       |
      | password  | UNIQ_USER[:password]  |
    And I submit form on login page
    Then I should not be logged in the system
    And I should see following text on login page:
      """
      Invalid email or password.
      """
    When I fill form on login page with data:
      | email     |                       |
      | password  |                       |
    And I submit form on login page
    Then I should not be logged in the system
    And I should see following text on login page:
      """
      Invalid email or password.
      """
      
  @p1
  Scenario: user can not login with incorrect credentials
    Given there is registered UNIQ_USER user
    And login page of web application
    When I fill form on login page with data:
      | email     | test@test.com         |
      | password  | UNIQ_USER[:password]  |
    And I submit form on login page
    Then I should see following text on login page:
      """
      Invalid email or password.
      """
    When I fill form on login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | test_login            |
    And I submit form on login page
    Then I should see following text on login page:
      """
      Invalid email or password.
      """
    When I fill form on login page with data:
      | email     | test@test.com         |
      | password  | test_login            |
    And I submit form on login page
    Then I should see following text on login page:
      """
      Invalid email or password.
      """
    When I fill form on login page with data:
      | email     | test.1234567890       |
      | password  |                       |
    Then I should not be logged in the system



  @bvt
  Scenario: user can not login until confirmation email is not confirmed
    Given sign up page of web application
    When I fill form on sign up page with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
      | password_confirmation | UNIQ_USER[:password]  |
    And I submit form on sign up page
    Then I should not be logged in the system
    And I should be redirected to home page
    And I should see following text on home page:
      """
      A message with a confirmation link has been sent to your email address. Please open the link to activate your account.
      """
    When I open login page
    And I fill form on login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit form on login page
    Then I should not be logged in the system
    And I should see following text on login page:
      """
      You have to confirm your account before continuing.
      """

  @bvt
  Scenario: canceled user can not login
    Given there is registered UNIQ_USER user
    When I fill form on login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit form on login page
    And I should be logged in the system
    And I should be redirected to home page
    And I open edit account page
    And I cancel account on edit account page
    And I confirm account cancelling on edit account page
    Then I should see following text on home page:
    """
    Bye! Your account was successfully cancelled. We hope to see you again soon.
    """
    When I click login menu item on home page
    Then login page should be displayed
    When I fill form on login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit form on login page
    Then I should see following text on login page:
    """
    Invalid email or password.
    """