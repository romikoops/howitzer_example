Feature: User Permissions
  As a user or as admin user
  I want to open pages of the system
  So I can see what in system is available to the user and to the admin user

  Background:
    Given registered user with parameters:
      | user_name | UNIQ_USER[:full_name]  |
      | email     | UNIQ_USER[:email]      |
      | password  | UNIQ_USER[:password]   |
    And registered admin user with parameters:
      | user_name | UNIQ_USER1[:full_name] |
      | email     | UNIQ_USER1[:email]     |
      | password  | UNIQ_USER1[:password]  |
    And article with parameters:
      | title     | UNIQ_ARTICLE[:title]   |
      | text      | UNIQ_ARTICLE[:text]    |

  Scenario: user can open Home page
    When I logged as UNIQ_USER[:email] user
    Then I should be redirected to Home page

  Scenario: user can open Articles list page
    When I logged as UNIQ_USER[:email] user
    And I click on Articles menu item
    Then I should be redirected to Articles list page

  Scenario: user can open Article page
    When I logged as UNIQ_USER[:email] user
    And I click on UNIQ_ARTICLE[:title] article on Articles list page
    Then I should be redirected to UNIQ_ARTICLE[:title] article page

  Scenario: user can open Users list page
    When I logged as UNIQ_USER[:email] user
    And I click on Users menu item
    Then I should be redirected to Users list page

  Scenario: user can open User page
    When I logged as UNIQ_USER[:email] user
    And I click on UNIQ_USER1[:email] user on Users list page
    Then I should be redirected to UNIQ_USER1[:email] user page

  Scenario: user can open Edit account page
    When I logged as UNIQ_USER[:email] user
    And I click on 'Edit account' menu item
    Then I should be redirected to Edit account page

  Scenario: user can signed out from the system
    When I logged as UNIQ_USER[:email] user
    And I click on Logout menu item
    Then I should be signed out
    And I should be redirected to Home page
    And I should see following text on Home page:
      """
      Signed out successfully.
      """

  Scenario: admin user can open Home page
    When I logged as UNIQ_USER1[:email] user
    Then I should be redirected to Home page

  Scenario: admin user can open Articles list page
    When I logged as UNIQ_USER1[:email] user
    And I click on Articles menu item
    Then I should be redirected to Articles list page

  Scenario: admin user can open Article page
    When I logged as UNIQ_USER1[:email] user
    And I click on UNIQ_ARTICLE[:title] article on Articles list page
    Then I should be redirected to UNIQ_ARTICLE[:title] article page
    
  Scenario: admin user can open New Article page
    When I logged as UNIQ_USER1[:email] user
    And I click on 'New Article' button on Listing articles page
    Then I should be redirected to New Article page

  Scenario: admin user can open Edit Article page
    When I logged as UNIQ_USER1[:email] user
    And I click on Edit button on UNIQ_ARTICLE[:title] article on Listing articles page
    Then I should be redirected to Edit Article page

  Scenario: admin user can open Users list page
    When I logged as UNIQ_USER1[:email] user
    And I click on Users menu item
    Then I should be redirected to Users list page

  Scenario: admin user can open User page
    When I logged as UNIQ_USER1[:email] user
    And I click on UNIQ_USER[:email] user on Users list page
    Then I should be redirected to UNIQ_USER[:email] user page

  Scenario: admin user can signed out from the system
    When I logged as UNIQ_USER1[:email] user
    And I click on Logout menu item
    Then I should be signed out
    And I should be redirected to Home page
    And I should see following text on Home page:
      """
      Signed out successfully.
      """
