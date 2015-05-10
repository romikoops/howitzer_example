@ok
Feature: Article Comment Adding
  As a user
  I want to add a comment to article
  So other users can see my opinion about article

  Background:
    Given there is registered UNIQ_USER user
    And there is UNIQ_ARTICLE article:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I am logged in as UNIQ_USER user
    And opened UNIQ_ARTICLE[:title] article page

  Scenario: user can add comment with valid comment body
    When I fill new comment form on article page with data:
      | body      | UNIQ_COMMENT[:text]   |
    And I submit new comment form on article page
    Then I should see following text on article page:
      """
      Comment was successfully added to current article.
      """
    And I should see comment on article page with data:
      | commenter | UNIQ_USER[:email]     |
      | comment   | UNIQ_COMMENT[:text]   |

  Scenario: user can not add comment with blank comment body
    When I fill new comment form on article page with blank data:
      | body      |                       |
    And I submit new comment form on article page
    Then I should see following text on article page:
      """
      Body can't be blank
      """