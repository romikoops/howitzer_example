@wip
Feature: Admin User Permissions
  As admin user
  I want to open pages of the system
  So I can see what in system is available to the admin user

  Background:
    Given registered admin user with parameters:
      | user_name | UNIQ_USER2[:full_name]  |
      | email     | UNIQ_USER2[:email]      |
      | password  | UNIQ_USER2[:password]   |
    And I logged as UNIQ_USER2[:email] user

  Scenario: admin user can open home page
    When I click on Home menu item
    Then I should be redirected to home page

  Scenario: admin user can open articles list page
    When I click on Articles menu item
    Then I should be redirected to articles list page

  Scenario: admin user can open article page
    Given registered user with parameters:
      | user_name | UNIQ_USER1[:full_name]  |
      | email     | UNIQ_USER1[:email]      |
      | password  | UNIQ_USER1[:password]   |
    And created article by UNIQ_USER2[:email] user with parameters:
      | title     | UNIQ_ARTICLE[:title]    |
      | text      | UNIQ_ARTICLE[:text]     |
    And comment to UNIQ_ARTICLE[:title] article created by UNIQ_USER1[:email] user with parameter:
      | body      | UNIQ_COMMENT1[:text]    |
    And comment to UNIQ_ARTICLE[:title] article created by UNIQ_USER2[:email] user with parameter:
      | body      | UNIQ_COMMENT2[:text]    |
    When I click on UNIQ_ARTICLE[:title] article on articles list page
    Then I should be redirected to UNIQ_ARTICLE[:title] article page
    And I should see article parameters with data:
      | title     | UNIQ_ARTICLE[:title]    |
      | text      | UNIQ_ARTICLE[:text]     |
    And I should see comments parameters with data:
      | commenter | UNIQ_USER1[:email]      |
      | comment   | UNIQ_COMMENT1[:text]    |
      | commenter | UNIQ_USER2[:email]      |
      | comment   | UNIQ_COMMENT2[:text]    |
    
  Scenario: admin user can open new article page
    When I click on 'New Article' button on articles list page
    Then I should be redirected to new article page

  Scenario: admin user can open edit article page
    When I click on Edit button on UNIQ_ARTICLE[:title] article on articles list page
    Then I should be redirected to edit article page

  Scenario: admin user can open users list page
    When I click on Users menu item
    Then I should be redirected to users list page

  Scenario: admin user can open user page
    Given registered user with parameters:
      | user_name | UNIQ_USER1[:full_name]  |
      | email     | UNIQ_USER1[:email]      |
      | password  | UNIQ_USER1[:password]   |
    When I click on UNIQ_USER1[:email] user on users list page
    Then I should be redirected to UNIQ_USER1[:email] user page
    And I should see user parameter with data:
      | email     | UNIQ_USER1[:email]      |

  Scenario: admin user can signed out
    When I click on Logout menu item
    Then I should be signed out
    And I should be redirected to home page
    And I should see following text on home page:
      """
      Signed out successfully.
      """
