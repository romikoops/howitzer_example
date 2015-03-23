Feature: Article Adding
  As a user
  I want to add a new article
  So other users can see my article

  Background:
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And opened Articles list page

  Scenario: user can add article with correct credentials
    When I click New article button on Articles list page
    And I fill New article form on New article page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I submit New article form on New article page
    Then I should see article parameters on Article page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    When I open Articles list page
    Then I should see article on Articles list page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
      
  Scenario: user can not add article with blank field
    When I click New article button on Articles list page
    And  I fill New article form on New article page with blank data:
      | title     |                       |
      | text      | UNIQ_ARTICLE[:text]   |
    And I submit New article form on New article page
    Then I should see following text on New article page:
      """
      2 errors prohibited this article from being saved:
      Title can't be blank
      Title is too short (minimum is 5 characters)
      """

  Scenario: user can not add article with title is too short
    When I click New article button on Articles list page
    And I fill New article form on New article page with data:
      | title     | 1234                  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I submit New article form on New article page
    Then I should see following text on New article page:
      """
      1 error prohibited this article from being saved:
      Title is too short (minimum is 5 characters)
      """