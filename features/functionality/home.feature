@ok
Feature: Home

  Background:
    Given I am logged in as admin user
    And there is article with parameters:
      | title | UNIQ_ARTICLE[:title] |
      | text | UNIQ_ARTICLE[:text] |

  Scenario: visitor can see home page of web application
    When I open home page
    Then I should see today form on home page with data:
       | article_title | UNIQ_ARTICLE[:title] |