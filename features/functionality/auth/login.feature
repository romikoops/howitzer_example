Feature: Log In
  As a user 
  I want to use my credentials to login the system
  So I can login the system

  @bvt
  Scenario: user can open Login page via menu
    Given Home page of web application
    When I click Login menu item on Home page
    Then Login page should be displayed

  @bvt
  Scenario: user can login with correct credentials
    Given registered user with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
    And Login page of web application
    When I fill form data on Login page:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit form on Login page
    Then I should be logged in the system
    And I should be redirected to Home page

  @bvt @wip
  Scenario: user can login with remembering credentials
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And Login page of web application
    When I fill Login form on Login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I check 'Remember me' checkbox
    And I submit Login form on Login page
    Then I should be logged in the system
    And I should be redirected to Home page
    When I click Logout menu item
    And I click Login menu item 
    Then I should see Login form on Login page with parameters:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    When I submit Login form on Login page
    Then I should be logged in the system
    And I should be redirected to Home page

  @p1 @wip
  Scenario: user can not login without credentials
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And Login page of web application
    When I fill Login form on Login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  |                       |
    And I submit Login form on Login page
    Then I should not be logged in the system
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email     |                       |
      | password  | UNIQ_USER[:password]  |
    And I submit Login form on Login page
    Then I should not be logged in the system
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email     |                       |
      | password  |                       |
    And I submit Login form on Login page
    Then I should not be logged in the system
    And I should see following text on Login page:
      """
      Invalid email or password.
      """
      
  @p1 @wip
  Scenario: user can not login with incorrect credentials
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And Login page of web application
    When I fill Login form on Login page with data:
      | email     | test@test.com         |
      | password  | UNIQ_USER[:password]  |
    And I submit Login form on Login page
    Then I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | test_login            |
    And I submit Login form on Login page
    Then I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email     | test@test.com         |
      | password  | test_login            |
    And I submit Login form on Login page
    Then I should see following text on Login page:
      """
      Invalid email or password.
      """
    When I fill Login form on Login page with data:
      | email     | test.1234567890       |
      | password  |                       |
    Then I should see following text on Login page:
      """
      Необходимо ввести допустимый адрес электронной почты
      """
  
  @bvt @wip
  Scenario: user can not login until confirmation email is not confirmed
    Given Sign up page of web application
    When I fill 'Sign up' form on Sign up page with data:
      | user_name             | UNIQ_USER[:full_name] |
      | email                 | UNIQ_USER[:email]     |
      | password              | UNIQ_USER[:password]  |
      | password_confirmation | UNIQ_USER[:password]  |
    And I submit 'Sign up' form on Sign up page
    Then I should not be logged in the system
    And I should be redirected to Home page
    And I should see following text on Home page:
      """
      A message with a confirmation link has been sent to your email address. Please open the link to activate your account.
      """
    When I fill Login form on Login page with data:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit Login form on Login page
    Then I should not be logged in the system
    And I should see following text on Login page:
      """
      You have to confirm your account before continuing.
      """

  @bvt @wip
  Scenario: canceled user can not login
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And Edit account page of web application
    When I click 'Cancel account' item on Edit account page
    And I submit action
    Then I should see following text on Home page:
      """
      Bye! Your account was successfully cancelled. We hope to see you again soon.
      """
    When I fill Login form on Login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit Login form on Login page
    Then I should see following text on Home page:
      """
      Invalid email or password.
      """
