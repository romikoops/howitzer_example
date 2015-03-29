@wip
Feature: Visitor Permissions
  As a visitor
  I want to view pages of the system
  So I can see what in system is available to the visitor

  Scenario: visitor can view login page
    When I click Login menu item
    Then I should be redirected to login page

  Scenario: visitor can view sign up page
    When I click 'Sign up' menu item 
    Then I should be redirected to sign up page

  Scenario: visitor can view home page
    When I click Home menu item 
    Then I should be redirected to home page

  Scenario: visitor can view articles list page
    When I click Articles menu item
    Then I should be redirected to articles list page

  Scenario: visitor can view article page
    Given registered user with parameters:
      | user_name | UNIQ_USER1[:full_name] |
      | email     | UNIQ_USER1[:email]     |
      | password  | UNIQ_USER1[:password]  |
    And registered user with parameters:
      | user_name | UNIQ_USER2[:full_name] |
      | email     | UNIQ_USER2[:email]     |
      | password  | UNIQ_USER2[:password]  |
    And article created by UNIQ_USER1[:email] user with parameters:
      | title     | UNIQ_ARTICLE[:title]   |
      | text      | UNIQ_ARTICLE[:text]    |
    And comment to UNIQ_ARTICLE[:title] article created by UNIQ_USER1[:email] user with parameter:
      | body      | UNIQ_COMMENT1[:text]   |
    And comment to UNIQ_ARTICLE[:title] article created by UNIQ_USER2[:email] user with parameter:
      | body      | UNIQ_COMMENT2[:text]   |
    When I click on UNIQ_ARTICLE[:title] article on articles list page
    Then I should be redirected to UNIQ_ARTICLE[:title] article page
    And I should see article parameters with data:
      | title     | UNIQ_ARTICLE[:title]   |
      | text      | UNIQ_ARTICLE[:text]    |
    And I should see comments parameters with data:
      | commenter | UNIQ_USER1[:email]     |
      | comment   | UNIQ_COMMENT1[:text]   |
      | commenter | UNIQ_USER2[:email]     |
      | comment   | UNIQ_COMMENT2[:text]   |