Feature: User Viewing
  As a user
  I want to view other user
  So I can see data of other user

  Background:
    Given there is registered UNIQ_USER user
    And there is registered UNIQ_USER1 user
    And I logged as user:
      | email     | UNIQ_USER1[:email]     |
      | password  | UNIQ_USER1[:password]  |
    And users page of web application

  Scenario: user is viewing other user on user page
    When I click on UNIQ_USER1[:email] link on users page
    Then I should see following text on user view page:
    """
    Email: UNIQ_USER1[:email]
    """