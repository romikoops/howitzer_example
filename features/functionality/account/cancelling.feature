
Feature: Account Cancelling
  As a user 
  I do not want to login the system
  So I can cancel my account

  Scenario: user can cancel his account
    Given there is registered UNIQ_USER user
    When I fill form on login page with data:
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And I submit form on login page
    And I should be logged in the system
    And I should be redirected to home page
    And I open edit account page
    And I cancel account on edit account page
    Then I should see following text on home page:
      """
      Bye! Your account was successfully cancelled. We hope to see you again soon.
      """