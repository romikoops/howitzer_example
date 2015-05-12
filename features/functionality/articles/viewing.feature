Feature: Article Viewing
  As a user
  I want to view my article
  So I can see what article page includes

  Background:
    Given there is UNIQ_ARTICLE article:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I am logged in as admin user
    And comment to UNIQ_ARTICLE[:title] article with parameter:
      | body      | UNIQ_COMMENT[:text]   |

  Scenario: admin is viewing article page
    When I navigate to UNIQ_ARTICLE[:title] article on article list page
    Then I should see following article parameters on article page:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I should see admin user comment on article page with data:
      | commenter | admin     |
      | comment   | UNIQ_COMMENT[:text]   |
    And I should see add comment form on article page
    And I should see body field on article page
    And I should see buttons: edit article, destroy comment, create comment on article page
    When I click back to articles link on article page
    Then I should be redirected to article list page