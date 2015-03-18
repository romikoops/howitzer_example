Feature: Article Comment Adding
  As a user
  I want to add a comment to article
  So other users can see my opinion about article

  Background:
    Given registered user with parameters
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And article with parameters
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And opened UNIQ_ARTICLE[:title] article page

  Scenario: user can add comment with valid comment body
    When I fill New Comment form on Article page with data:
      | body      | UNIQ_COMMENT[:text]   |
    And I submit New Comment form on Article page
    Then I should see following text on Article page:
      """
      Comment was successfully added to current article.
      """
    And I should see comment on Article page with data:
      | commenter | UNIQ_USER[:email]     |
      | comment   | UNIQ_COMMENT[:text]   |

  Scenario: user can not add comment with blank comment body
    When I fill New Comment form on Article page with blank data:
      | body      |                       |
    And I submit New Comment form on Article page
    Then I should see following text on Article page:
      """
      Body can't be blank
      """