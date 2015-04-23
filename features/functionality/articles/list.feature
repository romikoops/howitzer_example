@wip
Feature: Articles list
  As user
  I want to view my articles
  So I can view my articles in articles list

  Background:
    Given there is registered UNIQ_USER user
    And article with parameters:
      | title     | UNIQ_ARTICLE1[:title] |
      | text      | UNIQ_ARTICLE1[:text]  |
    And article with parameters:
      | title     | UNIQ_ARTICLE2[:title] |
      | text      | UNIQ_ARTICLE2[:text]  |

  Scenario: user can see articles in Articles list
    When I go to the articles list page
    Then I should see article on articles list page with data:
      | title     | UNIQ_ARTICLE1[:title] |
      | text      | UNIQ_ARTICLE1[:text]  |
    And I should see article on articles list page with data:
      | title     | UNIQ_ARTICLE2[:title] |
      | text      | UNIQ_ARTICLE2[:text]  |