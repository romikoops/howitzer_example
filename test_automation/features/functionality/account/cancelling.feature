Feature: Account Cancelling
  As a user 
  I want to cancel my account
  So I can cancel my account

  Scenario: user can cancel his account
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And Edit account page of web application
    When I click 'Cancel account' button on Edit account page
    And I submit action
    Then I should see following text on Home page:
      """
      Bye! Your account was successfully cancelled. We hope to see you again soon.
      """
    When I fill Login form on Login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit Login form on Login page
    Then I should see following text on Login page:
      """
      Invalid email or password.
      """