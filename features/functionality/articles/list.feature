@ok
Feature: Articles list
  As user
  I want to view my articles
  So I can view my articles in articles list

  Background:
    Given I am logged in as admin user
    And there is article with parameters:
      | title     | UNIQ_ARTICLE1[:title] |
      | text      | UNIQ_ARTICLE1[:text]  |
    And there is article with parameters:
      | title     | UNIQ_ARTICLE2[:title] |
      | text      | UNIQ_ARTICLE2[:text]  |
    And user logged out
    And there is registered UNIQ_USER user
    And I am logged in as UNIQ_USER user

  Scenario: user can see articles in Articles list
    When I open articles list page
    Then I should see UNIQ_ARTICLE1[:title] article on articles list page
    And I should see UNIQ_ARTICLE1[:text] article on articles list page
    And I should see UNIQ_ARTICLE2[:title] article on articles list page
    And I should see UNIQ_ARTICLE2[:text] article on articles list page