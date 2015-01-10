Feature: Article Comment Adding
  As a user
  I want to add a comment to article
  So other users can see my opinion about article

  Background:
    Given registered user with parameters
      | name   | email           | password |
      | Tester | tester@test.com | test1234 |
    And article with parameters
      | title         | text                           |
      | Cucumber test | Cucumber is very cool BDD tool |
    And opened article 'Cucumber test' page

  Scenario: with valid comment body
    When I fill form data on ArticlePage page:
      | body         |
      | Test comment |
    And I submit form on ArticlePage page
    Then I see following text on ArticlePage page:
      """
      Comment was successfully added to current article.
      """
    And I see comment displayed on ArticlePage page:
      | commenter       | comment      |
      | tester@test.com | Test comment |

  Scenario: with blank comment body
    When I fill form data on ArticlePage page:
      | body |
      |      |
    And I submit form on ArticlePage page
    Then I see following text on ArticlePage page:
      """
      Body can't be blank
      """