Feature: Article Comment Adding
  As a user
  I want to add a comment to article
  So other users can see my opinion about article

  Background:
    Given there is FACTORY_ARTICLE article
    And I am logged in as FACTORY_USER user
    And I am on FACTORY_ARTICLE article page

  Scenario: user can add comment with valid comment body
    When I fill new comment form on article page with data:
      | body      | FACTORY_COMMENT[:body]   |
    And I submit form on article page
    Then I should see following text on article page:
      """
      Comment was successfully added to current article.
      """
    And I should see user comment on article page with data:
      | commenter | FACTORY_USER[:email]     |
      | comment   | FACTORY_COMMENT[:body]   |

  Scenario: user can not add comment with blank comment body
    When I fill new comment form on article page with data:
      | body      |                       |
    And I submit new comment form on article page
    Then I should see following text on article page:
      """
      Body can't be blank
      """
