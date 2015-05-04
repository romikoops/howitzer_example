Feature: Article Adding
  As a user
  I want to add a new article
  So other users can see my article

  Background:
    Given logged in as admin user
    And I open articles list page

  Scenario: user can add article with correct data
    When I click new article button on articles list page
    And I fill form on new article page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I submit form on new article page
    Then I should see article on article page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    When I open articles list page
    Then I should see article on articles list page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |

  Scenario: user can not add article with blank field
    When I click new article button on articles list page
    And  I fill form on new article page with data:
      | title     |                       |
      | text      |                       |
    And I submit form on new article page
    Then I should see following text on new article page:
    """
   2 errors prohibited this article from being saved: Title can't be blank Title is too short (minimum is 5 characters)
    """

  Scenario: user can not add article with title is too short
    When I click new article button on articles list page
    And I fill form on new article page with data:
      | title     | 1234                  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I submit form on new article page
    Then I should see following text on new article page:
    """
    1 error prohibited this article from being saved: Title is too short (minimum is 5 characters)
    """