@ok
Feature: Home

  Background:
    Given I am logged in as admin user
    And I open articles list page
    And there is article with parameters:
      | title | UNIQ_ARTICLE[:title] |
      | text | UNIQ_ARTICLE[:text] |

  Scenario: visitor can see home page of web application
    When I open home page
    Then I should see today form on home page with data:
      | creation_time | UNIQ_ARTICLE[:creation_time] |
      | article_title | UNIQ_ARTICLE[:title] |