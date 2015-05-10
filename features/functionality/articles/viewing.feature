Feature: Article Viewing
  As a user
  I want to view my article
  So I can see what article page includes

  Background:
    Given there is registered UNIQ_USER user
    And there is UNIQ_ARTICLE article:
      | title     | UNIQ_ARTICLE[:title] |
      | text      | UNIQ_ARTICLE[:text]  |
    And I am logged in as UNIQ_USER user
    And comment to UNIQ_ARTICLE[:title] article with parameter:
      | body      | UNIQ_COMMENT[:text]   |

  Scenario: user is viewing article page
    When I open article page for UNIQ_ARTICLE[:title]
    Then I should see following article parameters on article page:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I should see comment on article page with data:
      | commenter | UNIQ_USER[:email]     |
      | comment   | UNIQ_COMMENT[:text]   |
    And I should see add comment form on article page
    And I should see body field on article page
    When I click Back to Articles link on article page
    Then I should be redirected to article list page