@wip
Feature: Article Viewing
  As a user
  I want to view my article
  So I can see what article page includes

  Background:
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And comment to UNIQ_ARTICLE[:title] article with parameter:
      | body      | UNIQ_COMMENT[:text]   |

  Scenario: user is viewing article page
    When I open UNIQ_ARTICLE[:title] article page     
    Then I should see article parameters with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I should see comment parameters with data:
      | commenter | UNIQ_USER[:email]     |
      | comment   | UNIQ_COMMENT[:text]   |
    And I should see Add comment form on article page
    And I should see Body field on article page
    And I should see buttons: Edit article, Destroy comment, Create comment on article page
    When I click Back to articles link on article page
    Then I should be redirected to articles list page