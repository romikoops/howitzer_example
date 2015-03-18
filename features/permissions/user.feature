Feature: User Permissions
  As a user
  I want to open pages of the system
  So I can see what in system is available to the user

  Background:
    Given registered user with parameters:
      | user_name | UNIQ_USER1[:full_name]  |
      | email     | UNIQ_USER1[:email]      |
      | password  | UNIQ_USER1[:password]   |
    And registered admin user with parameters:
      | user_name | UNIQ_USER2[:full_name]  |
      | email     | UNIQ_USER2[:email]      |
      | password  | UNIQ_USER2[:password]   |
    And I logged as UNIQ_USER1[:email] user

  Scenario: user can open Home page
    When I click on Home menu item
    Then I should be redirected to Home page

  Scenario: user can open Articles list page
    When I click on Articles menu item
    Then I should be redirected to Articles list page

  Scenario: user can open Article page
    Given created article by UNIQ_USER2[:email] user with parameters:
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

  Scenario: user can open Users list page
    When I click on Users menu item
    Then I should be redirected to Users list page

  Scenario: user can open User page
    When I click on UNIQ_USER2[:email] user on Users list page
    Then I should be redirected to UNIQ_USER2[:email] user page
    And I should see user parameter with data:
      | email     | UNIQ_USER1[:email]      |

  Scenario: user can open Edit account page
    When I click on 'Edit account' menu item
    Then I should be redirected to Edit account page

  Scenario: user can signed out
    When I click on Logout menu item
    Then I should be signed out
    And I should be redirected to Home page
    And I should see following text on Home page:
      """
      Signed out successfully.
      """