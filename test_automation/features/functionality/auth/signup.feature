@ok
Feature: Sign Up
  @bvt
  Scenario: Visitor can open sign up page via menu
    Given home page of web application
    When I click Sign up menu item on home page
    Then sign up page should be displayed
  @bvt
  Scenario: User can sign up with correct data
    Given sign up page of web application
    When I fill form data on sign up page:
      | user_name              | UNIQ_USER[:full_name] |
      | email                  | UNIQ_USER[:email]     |
      | password               | UNIQ_USER[:password]  |
      | password_confirmation  | UNIQ_USER[:password]  |
    And I submit form on sign up page
    Then I should not be logged in the system
    And home page should be displayed
    And I see following text on home page:
    """
    A message with a confirmation link has been sent to your email address. Please open the link to activate your account.
    """
    Then I should receive confirmation instruction email for UNIQ_USER[:email] recipient
    When I confirm UNIQ_USER[:email] account from confirmation instruction email
    Then login page should be displayed
    And I see following text on login page:
    """
    Your account was successfully confirmed.
    """
    When I fill form data on login page:
      | email    | UNIQ_USER[:email]    |
      | password | UNIQ_USER[:password] |
    And I submit form on login page
    Then I should be logged in the system
    And home page should be displayed

  @p1
  Scenario: User can not sign up with blank data
  @p1
  Scenario: User can not sign up with incorrect data
  @p1
  Scenario: User can not sign up with duplicated email

