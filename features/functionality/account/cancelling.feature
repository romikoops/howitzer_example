
Feature: Account Cancelling
  As a user 
  I do not want to login the system
  So I can cancel my account

  Scenario: user can cancel his account
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    When I fill form on Login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit form on Login page
    And I should be logged in the system
    And I should be redirected to Home page
    And I open Edit account page
    And I cancel account on Edit account page
    And I confirm account cancelling
    Then I should see following text on Home page:
      """
      Bye! Your account was successfully cancelled. We hope to see you again soon.
      """

