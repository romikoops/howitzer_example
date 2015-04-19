@wip
Feature: Article Comment Destroying
  As a user
  I want to delete a comment of article
  So other users can not see my opinion about article

  Background:
    Given there is registered UNIQ_USER user
    And article with parameters:
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And comment for UNIQ_ARTICLE[:title] article with parameter:
      | body      | UNIQ_COMMENT[:text]   |
    And opened UNIQ_ARTICLE[:title] article page

  Scenario: user can remove comment with confirmation action
    When I click Destroy comment button on article page
    And I confirm action
    Then I should not see comment on article page with data:
      | body      | UNIQ_COMMENT[:text]   |

  Scenario: user can not remove comment without confirmation action
    When I click Destroy comment button on article page
    And I don't confirm action
    Then I should see comment on article page with data:
      | body      | UNIQ_COMMENT[:text]   |