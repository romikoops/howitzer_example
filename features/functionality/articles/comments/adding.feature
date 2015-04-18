Feature: Article Comment Adding
  As a user
  I want to add a comment to article
  So other users can see my opinion about article

  Background:
    Given there is FACTORY_ARTICLE article
    And I am logged in as FACTORY_USER user
    And I am on FACTORY_ARTICLE article page

  Scenario: user can add comment with valid comment body
    When I fill form on article page with data:
      | body      | FACTORY_COMMENT[:body]   |
    And I submit form on article page
    Then I should see following text on article page:
      """
      Comment was successfully added to current article.
      """
    And I see comment displayed on article page:
      | commenter | FACTORY_USER[:email]     |
      | comment   | FACTORY_COMMENT[:body]   |