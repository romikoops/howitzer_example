Feature: Article Comment Adding
  As a user
  I want to add a comment to article
  So other users can see my opinion about article

  Background:
    Given created FACTORY_USER entity
    And created FACTORY_ARTICLE entity
    And logged in FACTORY_USER user
    And opened article FACTORY_ARTICLE[:title] page

  Scenario: with valid comment body
    When I fill form data on article page:
      | body | Test comment|
    And I submit form on Article page
    Then I see following text on Article page:
      """
      Comment was successfully added to current article.
      """
    And I see comment displayed on Article page:
      | commenter       | tester@test.com |
      | comment         | Test comment    |

  Scenario: with blank comment body
    When I fill form data on Article page:
      | body | |
    And I submit form on Article page
    Then I see following text on Article page:
      """
      Body can't be blank
      """