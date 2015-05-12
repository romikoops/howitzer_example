Feature: Article Comment Destroying
  As a user
  I want to delete a comment of article
  So other users can not see my opinion about article

  Background:
    Given I am logged in as admin user
    And there is article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And there is comment for UNIQ_ARTICLE[:title] article with parameter:
      | body      | UNIQ_COMMENT[:text]   |
    And opened UNIQ_ARTICLE[:title] article page

  Scenario: user can remove comment with confirmation action
    When I destroy UNIQ_COMMENT[:text] comment with confirmation on article page
    Then I should not see comment on article page with data:
      | body      | UNIQ_COMMENT[:text]   |

  Scenario: user can not remove comment without confirmation action
    When I destroy UNIQ_COMMENT[:text] comment without confirmation on article page
    Then I should see comment on article page with data:
      | commenter | admin                 |
      | body      | UNIQ_COMMENT[:text]   |