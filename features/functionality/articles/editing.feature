Feature: Article Editing
  As a user 
  I want to edit my article
  So other users can see my edited article

  Background:
    Given registered user with parameters
      | user_name | UNIQ_USER[:full_name] |
      | email     | UNIQ_USER[:email]     |
      | password  | UNIQ_USER[:password]  |
    And article with parameters
      | title     | UNIQ_ARTICLE[:title]  |
      | text      | UNIQ_ARTICLE[:text]   |
    And opened UNIQ_ARTICLE[:title] article page

  Scenario: user can edit article with correct credentials
    When I click Edit article button on Article page
    And I fill Edit article form on Edit article page with data:
      | title     | UNIQ_ARTICLE1[:title]  |
      | text      | UNIQ_ARTICLE1[:text]   |
    And I submit Edit article form on Edit article page
    Then I should see following article parameters on Article page:
      | title     | UNIQ_ARTICLE1[:title]  |
      | text      | UNIQ_ARTICLE1[:text]   |

  Scenario: user can not edit article with blank title
    When I click Edit article button on Article page
    And I fill Edit article form on Edit article page with data:
      | title     |                       |
      | text      |                       |
    And I submit Edit article form on Edit article page
    Then I should see following text on Edit article page:
      """
      2 errors prohibited this article from being saved:
      Title can't be blank
      Title is too short (minimum is 5 characters)
      """
      
  Scenario: user can not edit article with title is too short
    When I click Edit article button on Article page
    And I fill Edit article form on Edit article page with data:
      | title     | 1234                  |
      | text      |                       |
    And I submit Edit article form on Edit article page
    Then I should see following text on Edit article page:
      """
      1 error prohibited this article from being saved:
      Title is too short (minimum is 5 characters)
      """
