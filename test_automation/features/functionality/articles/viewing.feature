Feature: Article Viewing
  As a user
  I want to view my article
  So I can see what Article page includes

  Background:
    Given registered user with parameters:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And comment to UNIQ_ARTICLE[:title] article with parameter:
      | body      | UNIQ_COMMENT[:text]   |

  Scenario: user is viewing Article page
    When I open UNIQ_ARTICLE[:title] article page     
    Then I should see article parameters with data:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And I should see comment parameters with data:
      | commenter | UNIQ_USER[:email]     |
      | comment   | UNIQ_COMMENT[:text]   |
    And I should see Add comment form on Article page
    And I should see Body field on Article page
    And I should see buttons: Edit article, Destroy comment, Create comment on Article page
    When I click Back to articles link on Article page
    Then I should be redirected to Articles list page