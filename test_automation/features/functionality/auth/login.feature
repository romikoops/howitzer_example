@ok
Feature: Log In
  @bvt
  Scenario: Visitor can open login page via menu
    Given home page of web application
    When I click Login menu item on home page
    Then login page should be displayed

  @bvt
  Scenario: Visitor can login with correct credentials
    Given login page of web application
    When I fill form data on login page:
      | email    | admin@test.com |
      | password | 1234567890     |
    And I submit form on login page
    Then I should be logged in the system
    And home page should be displayed

#  Scenario: Visitor can login with remembering credentials
#  Scenario: Visitor can not login without credentials
#  Scenario: Visitor can not login with incorrect credentials
#  Scenario: Visitor can initiate sign up

