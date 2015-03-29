@wip
Feature: Article Comment Adding
  As a user
  I want to add a comment to article
  So other users can see my opinion about article

  Background:
    Given created FACTORY_USER entity
    And created FACTORY_ARTICLE entity
    And logged in FACTORY_USER user
    And opened article FACTORY_ARTICLE[:title] page

  Scenario: user can add comment with valid comment body
    When I fill form on Article page with data:
      | body      | UNIQ_COMMENT[:text]   |
    And I submit form on Article page
    Then I should see following text on Article page:
      """
      Comment was successfully added to current article.
      """
    And I see comment displayed on Article page:
      | commenter | UNIQ_USER[:email]     |
      | comment   | UNIQ_COMMENT[:text]   |

  Scenario: user can not add comment with blank comment body
    When I fill form on Article page with data:
      | body      |                       |
    And I submit form on Article page
    Then I should see following text on Article page:
      """
      Body can't be blank
      """