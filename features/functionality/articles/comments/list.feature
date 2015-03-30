@wip
Feature: Article Comments List
  As user
  I want to view my article comments 
  So I can view my article comments on article comments list on article page

  Background:
    Given registered user with data:
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And comment to UNIQ_ARTICLE[:title] article with parameter:
      | body      | UNIQ_COMMENT1[:text]  |
    And comment to UNIQ_ARTICLE[:title] article with parameter:
      | body      | UNIQ_COMMENT2[:text]  |

  Scenario: user can see article comments on Article comments list on article page
    When I go to the UNIQ_ARTICLE[:title] article page
    Then I should see comment on article page with data:
      | commenter | UNIQ_USER[:email]     |
      | body      | UNIQ_COMMENT1[:text]  |
    And I should see comment on article page with data:
      | commenter | UNIQ_USER[:email]     |
      | body      | UNIQ_COMMENT2[:text]  |