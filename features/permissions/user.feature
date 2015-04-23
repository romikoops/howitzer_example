@wip
Feature: User Permissions
  As a user
  I want to open pages of the system
  So I can see what in system is available to the user

  Background:
    Given there is registered UNIQ_USER1 user
    And registered admin user with parameters:
      | user_name | UNIQ_USER2[:full_name]  |
      | email     | UNIQ_USER2[:email]      |
      | password  | UNIQ_USER2[:password]   |
    And I logged as UNIQ_USER1[:email] user

  Scenario: user can open home page
    When I click on Home menu item
    Then I should be redirected to home page

  Scenario: user can open articles list page
    When I click on Articles menu item
    Then I should be redirected to articles list page

  Scenario: user can open article page
    Given created article by UNIQ_USER2[:email] user with parameters:
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

  Scenario: user can open users list page
    When I click on users menu item
    Then I should be redirected to users list page

  Scenario: user can open user page
    When I click on UNIQ_USER2[:email] user on users list page
    Then I should be redirected to UNIQ_USER2[:email] user page
    And I should see user parameter with data:
      | email     | UNIQ_USER1[:email]      |

  Scenario: user can open edit account page
    When I click on 'Edit account' menu item
    Then I should be redirected to edit account page

  Scenario: user can signed out
    When I click on logout menu item
    Then I should be signed out
    And I should be redirected to home page
    And I should see following text on home page:
      """
      Signed out successfully.
      """