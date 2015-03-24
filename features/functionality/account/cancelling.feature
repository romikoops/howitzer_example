@wip
Feature: Account Cancelling
  As a user 
  I do not want to login the system
  So I can cancel my account

  Scenario: user can cancel his account
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And Edit account page of web application for UNIQ_USER[:email] user
    When I click 'Cancel account' button on Edit account page
    And I confirm action
    Then I should see following text on Home page:
      """
      Bye! Your account was successfully cancelled. We hope to see you again soon.
      """