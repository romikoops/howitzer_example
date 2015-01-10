Feature: Article Comment Adding
  As a user
  I want to add a comment to article
  So other users can see my opinion about article

  Background:
    Given registered user with parameters
      | name     | Tester          |
      | email    | tester@test.com |
      | password | test1234        |
    And article with parameters
      | title         | Cucumber test                  |
      | text          | Cucumber is very cool BDD tool |
    And opened article 'Cucumber test' page

  Scenario: with valid comment body
    When I fill form data on Article page:
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