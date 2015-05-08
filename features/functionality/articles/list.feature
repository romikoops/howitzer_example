@ok
Feature: Articles list
  As user
  I want to view my articles
  So I can view my articles in articles list

  Background:
    Given there is UNIQ_ARTICLE1 article:
      | title     | UNIQ_ARTICLE1[:title] |
      | text      | UNIQ_ARTICLE1[:text]  |
    And there is UNIQ_ARTICLE2 article:
      | title     | UNIQ_ARTICLE2[:title] |
      | text      | UNIQ_ARTICLE2[:text]  |
    And there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user

  Scenario: user can see articles in Articles list
    When I open articles list page
    Then I should see following article parameters on articles list page:
      | title     | UNIQ_ARTICLE1[:title] |
      | text      | UNIQ_ARTICLE1[:text]  |
    And I should see following article parameters on articles list page:
      | title     | UNIQ_ARTICLE2[:title] |
      | text      | UNIQ_ARTICLE2[:text]  |