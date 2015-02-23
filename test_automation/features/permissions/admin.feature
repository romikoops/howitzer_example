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

  Scenario: admin user can open Home page
    When I click on Home menu item
    Then I should be redirected to Home page

  Scenario: admin user can open Articles list page
    When I click on Articles menu item
    Then I should be redirected to Articles list page

  Scenario: admin user can open Article page
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
    When I click on UNIQ_ARTICLE[:title] article on Articles list page
    Then I should be redirected to UNIQ_ARTICLE[:title] article page
    And I should see article parameters with data:
      | title     | UNIQ_ARTICLE[:title]    |
      | text      | UNIQ_ARTICLE[:text]     |
    And I should see comments parameters with data:
      | commenter | UNIQ_USER1[:email]      |
      | comment   | UNIQ_COMMENT1[:text]    |
      | commenter | UNIQ_USER2[:email]      |
      | comment   | UNIQ_COMMENT2[:text]    |
    
  Scenario: admin user can open New Article page
    When I click on 'New Article' button on Articles list page
    Then I should be redirected to New Article page

  Scenario: admin user can open Edit Article page
    When I click on Edit button on UNIQ_ARTICLE[:title] article on Articles list page
    Then I should be redirected to Edit Article page

  Scenario: admin user can open Users list page
    When I click on Users menu item
    Then I should be redirected to Users list page

  Scenario: admin user can open User page
    Given registered user with parameters:
      | user_name | UNIQ_USER1[:full_name]  |
      | email     | UNIQ_USER1[:email]      |
      | password  | UNIQ_USER1[:password]   |
    When I click on UNIQ_USER1[:email] user on Users list page
    Then I should be redirected to UNIQ_USER1[:email] user page
    And I should see user parameter with data:
      | email     | UNIQ_USER1[:email]      |

  Scenario: admin user can signed out
    When I click on Logout menu item
    Then I should be signed out
    And I should be redirected to Home page
    And I should see following text on Home page:
      """
      Signed out successfully.
      """
