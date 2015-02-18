Feature: Visitor Permissions
  As a visitor
  I want to view pages of the system
  So I can see what in system is available to the visitor

  Scenario: visitor can view Login page
    When I click Login menu item
    Then I should be redirected to Login page

  Scenario: visitor can view Sign up page
    When I click 'Sign up' menu item 
    Then I should be redirected to Sign up page

  Scenario: visitor can view Home page
    When I click Home menu item 
    Then I should be redirected to Home page

  Scenario: visitor can view Articles list page
    When I click Articles menu item
    Then I should be redirected to Articles list page

  Scenario: visitor can view Article page
    Given created article by UNIQ_USER[:email] user with parameters:
      | title     | UNIQ_ARTICLE[:title] |
      | text      | UNIQ_ARTICLE[:text]  |
    And comment to UNIQ_ARTICLE[:title] article created by UNIQ_USER1[:email] user with parameter:
      | body      | UNIQ_COMMENT1[:text] |
    And comment to UNIQ_ARTICLE[:title] article created by UNIQ_USER2[:email] user with parameter:
      | body      | UNIQ_COMMENT2[:text] |
    When I click on UNIQ_ARTICLE[:title] article on Articles list page
    Then I should be redirected to UNIQ_ARTICLE[:title] article page
    And I should see article parameters with data:
      | title     | UNIQ_ARTICLE[:title] |
      | text      | UNIQ_ARTICLE[:text]  |
    And I should see comments parameters with data:
      | commenter | UNIQ_USER1[:email]   |
      | comment   | UNIQ_COMMENT1[:text] |
      | commenter | UNIQ_USER2[:email]   |
      | comment   | UNIQ_COMMENT2[:text] |