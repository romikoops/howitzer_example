@ok
Feature: Home

  Background:
    Given I am logged in as admin user
    And I open articles list page
    When I click new article button on articles list page
    And I fill form on new article page with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I submit form on new article page
    And I click Articles menu item on article page
    And I should see UNIQ_ARTICLE[:title] article on articles list page

  Scenario: visitor can see home page of web application
    Given home page of web application
    Then I should see Today form on home page with data:
      | creation_time | UNIQ_ARTICLE[:creation_time] |
      | article_title | UNIQ_ARTICLE[:title] |